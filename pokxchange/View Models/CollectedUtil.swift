//
//  CollectedCardsWebService.swift
//  pokxchange
//
//  Created by abdelillah ghomari on 7/28/21.
//

import Foundation

class CollectedUtil {
    
    var collection: Collection = Collection(userId: myIdGetter()!, cards: [])
    private let defaults = UserDefaults.standard

    init(id: UUID) {
        guard let token = defaults.string(forKey: "jsonwebtoken") else {
            return
        }
        CardWebService().getCollected(token: token, id: id) { [weak self] result in
            switch result {
            case .success(let collection):
                DispatchQueue.main.async {
                    self?.collection = collection
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    print(error)
                }
            }
        }
    }
    
    func getCollectedCardById(cardId: Int) -> CollectedCard? {
        return collection.cards.filter{ collectedCard in
            collectedCard.cardId == cardId
        }.first
    }
}
