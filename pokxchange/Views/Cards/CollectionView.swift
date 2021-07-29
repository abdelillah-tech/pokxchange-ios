//
//  MyCollectionView.swift
//  pokxchange
//
//  Created by abdelillah ghomari on 6/29/21.
//
enum CollectionViewMode {
    case friends
    case mine
    case all
}

import SwiftUI

struct CollectionView: View {
    let id: UUID?
    let username: String
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @EnvironmentObject private var loginVM: LoginViewModel
    @StateObject private var collectionVM = CollectionViewModel()
    @StateObject private var tradeVM = TradeViewModel()
    @State var searchText = ""
    @State var searching = false
    @State var showMyCards = false
    @State var showError = true
    @State var viewMode: CollectionViewMode
    
    init(id: UUID?, username: String, viewMode: CollectionViewMode){
        self.id = id
        self.username = username
        _viewMode = State(initialValue: viewMode)
    }
    
    func changeViewMode() -> Void {
        if(!loginVM.authenticated) {
            viewMode = CollectionViewMode.all
        }
    }
    
    var body: some View {
        switch collectionVM.state {
        case .idle:
            Color.clear
                .onAppear{
                    switch viewMode {
                    case CollectionViewMode.friends:
                        collectionVM.loadUserCollection(id: id!)
                        showMyCards = true
                    default:
                        collectionVM.loadCollection(id: nil)
                    }
                }
        case .loading:
            ProgressView()
        case .failed(let error):
            VStack {
                Text(errorToText(error: error as! NetworkError))
                Button("Retry") {
                    collectionVM.loadCollection(id: nil)
                    showMyCards = false
                }
            }
        case .loaded(let collection):
            VStack {
                SearchBar(searchText: $searchText, searching: $searching)

                if(loginVM.authenticated &&
                    viewMode != CollectionViewMode.friends) {
                    Button("My Cards"){
                        showMyCards.toggle()
                        if showMyCards {
                            viewMode = CollectionViewMode.mine
                            collectionVM.loadUserCollection(id: nil)
                        } else {
                            collectionVM.loadCollection(id: nil)
                        }
                    }
                    .foregroundColor(.white)
                    .padding()
                    .background(isValidColor(state: showMyCards))
                    .cornerRadius(25)
                }
                List {
                    ForEach(collection.filter({(card: GroupedCard) -> Bool in
                        return card.card.name.lowercased().hasPrefix(searchText.lowercased()) || searchText == ""
                    }), id: \.self) { card in
                        if viewMode == CollectionViewMode.friends {

                            NavigationLink(destination: TradeView(card: card.card, userId: id!)) {
                                CardItemView(card: card, viewMode: viewMode)
                            }
                        } else  {
                            NavigationLink(destination: CardView(card: card.card, taux: 1)) {
                                CardItemView(card: card, viewMode: viewMode)
                            }
                        }
                    }
                }
                
            }
            .onAppear{
                if(!loginVM.authenticated) {
                    if(viewMode == CollectionViewMode.friends){
                        self.mode.wrappedValue.dismiss()
                    }
                    viewMode = CollectionViewMode.all
                }
            }
            .navigationTitle(username)
            .navigationBarTitleDisplayMode(.inline)
            .listStyle(GroupedListStyle())
        }
    }
}
