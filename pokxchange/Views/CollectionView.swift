//
//  MyCollectionView.swift
//  pokxchange
//
//  Created by abdelillah ghomari on 6/29/21.
//
enum CollectionViewMode {
    case friends
    case requests
    case mine
}

import SwiftUI

struct CollectionView: View {
    let id: UUID?
    let username: String
    @EnvironmentObject private var loginVM: LoginViewModel
    @StateObject private var collectionVM = CollectionViewModel()
    @StateObject private var tradeVM = TradeViewModel()
    @State var collection = [Card]()
    @State var width = 300

    let viewMode: CollectionViewMode

    var body: some View {
            List {
                ForEach(collection, id: \.id) { card in
                    if viewMode == CollectionViewMode.friends {
                        NavigationLink(destination: TradeView(card: card)) {
                            CardItemView(card: card, viewMode: viewMode)
                        }
                    } else  {
                        NavigationLink(destination: CardView(card: card, taux: 1)) {
                            CardItemView(card: card, viewMode: viewMode)
                        }
                    }
                }
            }.onAppear{
                switch viewMode {
                case CollectionViewMode.friends:
                    collectionVM.getCollection(id: id!)
                    collection = collectionVM.collection
                case CollectionViewMode.requests:
                    tradeVM.getTradeRequests()
                    collection = tradeVM.collection
                default:
                    collectionVM.getAllCards()
                    collection = collectionVM.collection

                }
            }
            .navigationTitle(username)
            .navigationBarTitleDisplayMode(.inline)
    }
}

struct CollectionView_Previews: PreviewProvider {
    static var id: UUID?
    static var username: String = ""
    static var viewMode: CollectionViewMode = CollectionViewMode.mine
    static var previews: some View {
        CollectionView(id: id, username: username, viewMode: viewMode)
    }
}
