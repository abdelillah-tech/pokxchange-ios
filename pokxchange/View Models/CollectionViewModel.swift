//
//  CollectionViewModel.swift
//  pokxchange
//
//  Created by abdelillah ghomari on 7/2/21.
//

import SwiftUI

class CollectionViewModel: ObservableObject {
    
    @EnvironmentObject private var loginVM: LoginViewModel
    @Published var collection = [Card]()
    @State var authenticated = false
        
    func getCollection(id: UUID) {
        CardWebService().getCollection(id: id) { result in
            switch result {
                case .success(let cards):
                    DispatchQueue.main.async {
                        self.collection = cards
                    }
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
    
    func getAllCards() {
        CardWebService().getAllCards() { result in
            switch result {
                case .success(let cards):
                    DispatchQueue.main.async {
                        self.collection = cards
                    }
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
    
    func saveCard(card: Card, authenticated: Bool) {
        //getMyCollection(authenticated: authenticated)
        //let collection = self.collection
        //CardLocalservice().addToCollection(card: card, collection: collection)
    }
}
