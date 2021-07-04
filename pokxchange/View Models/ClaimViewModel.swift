//
//  ClaimViewModel.swift
//  pokxchange
//
//  Created by abdelillah ghomari on 7/2/21.
//

import Foundation


class ClaimViewModel: ObservableObject {
    
    @Published var card: Card?

    func claim(authenticated: Bool) -> Bool {
        let claim = CardWebService().claim()
        DispatchQueue.main.async {
            self.card = claim.0
            CollectionViewModel().saveCard(card: self.card!, authenticated: authenticated)
        }
        return claim.1
    }
    
    func reset() {
        self.card = nil
    }
}
