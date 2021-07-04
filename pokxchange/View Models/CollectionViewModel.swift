//
//  CollectionViewModel.swift
//  pokxchange
//
//  Created by abdelillah ghomari on 7/2/21.
//

import SwiftUI

class CollectionViewModel: ObservableObject {
    
    @Published var collection = [Card]()
    
    func getCollection(id: Int) {
        collection = CardWebService().getCollection(id: id)
    }
    
    func getMyCollection() {
        collection = CardLocalservice().getCollection()
    }
    
    func saveCard(card: Card) {
        getMyCollection()
        let collection = self.collection
        CardLocalservice().addToCollection(card: card, collection: collection)
    }
}
