//
//  CollectionViewModel.swift
//  pokxchange
//
//  Created by abdelillah ghomari on 7/2/21.
//

import SwiftUI

class CollectionViewModel: ObservableObject {
    
    @EnvironmentObject private var loginVM: LoginViewModel
    @Published var collection: [GroupedCard] = []
    @Published private(set) var state = LoaderState<GroupedCard>.idle
    private let defaults = UserDefaults.standard

    
    func loadCollection(id: UUID?) {
        state = .loading

        CardWebService().getCollection() { [weak self] result in
            switch result {
            case .success(let collection):
                
                let groupedCards = collection.reduce(into: [:]) { result, card in
                    result[card, default: 0] += 1
                }.map{item in GroupedCard(card: item.key, quantity: item.value)}
                
                DispatchQueue.main.async {
                    self?.state = .loaded(groupedCards)
                    self?.collection = groupedCards
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.state = .failed(error)
                }
            }
        }
    }
    
    func loadUserCollection(id: UUID?) {
        state = .loading
        guard let token = defaults.string(forKey: "jsonwebtoken") else {
            return
        }
        CardWebService().getUserCollection(token: token, id: id != nil ? id : myIdGetter()) { [weak self] result in
            switch result {
            case .success(let collection):
                let groupedCards = collection.reduce(into: [:]) { result, card in
                    result[card, default: 0] += 1
                }.map{item in GroupedCard(card: item.key, quantity: item.value)}
                
                DispatchQueue.main.async {
                    self?.state = .loaded(groupedCards)
                    self?.collection = groupedCards
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.state = .failed(error)
                }
            }
        }
    }
    
    func saveCard(card: Card, authenticated: Bool) {
        //getMyCollection(authenticated: authenticated)
        //let collection = self.collection
        //CardLocalservice().addToCollection(card: card, collection: collection)
    }
}
