//
//  TradeViewModel.swift
//  pokxchange
//
//  Created by abdelillah ghomari on 7/4/21.
//

import Foundation

class TradeViewModel: ObservableObject {
    
    @Published var collection = [Card]()
    
    func getCollection(id: UUID) {
        //collection = CardWebService().getCollection(id: id)
    }
    
    func getMyCollection() {
        collection = CardLocalservice().getCollection()
    }
    
    func saveCard(card: Card) {
        getMyCollection()
        let collection = self.collection
        CardLocalservice().addToCollection(card: card, collection: collection)
    }
    
    func getTradeRequests() {
        collection = TradeWebService().getTradeRequests()
    }
        
    
    func sendTradeRequest(id: Int) -> Bool {
        return TradeWebService().sendTradeRequest(id: id);
    }
    
    func approveTradeRequest(id: Int) -> Bool {
        return TradeWebService().approveTradeRequest(id: id);
    }
}
