//
//  ClaimViewModel.swift
//  pokxchange
//
//  Created by abdelillah ghomari on 7/2/21.
//

import Foundation

func claim() -> Card? {
    var bonusCard: Card?
    guard let token = UserDefaults.standard.string(forKey: "jsonwebtoken") else {
        return nil
    }
    CardWebService().bonus(token: token, id : myIdGetter()) { result in
        switch result {
        case .success(let card):
            DispatchQueue.main.async {
                bonusCard = card
            }
        case .failure(_): break
        }
    }
    return bonusCard
}

