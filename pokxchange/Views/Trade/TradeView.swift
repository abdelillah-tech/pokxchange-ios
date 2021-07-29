//
//  TradeView.swift
//  pokxchange
//
//  Created by abdelillah ghomari on 6/29/21.
//

import SwiftUI

struct TradeView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @EnvironmentObject private var loginVM: LoginViewModel
    @StateObject private var collectionVM = CollectionViewModel()
    @StateObject private var tradeVM = TradeViewModel()
    @State private var selectedCard: GroupedCard?
    @State private var showingCard: Bool = false
    @State private var taux: CGFloat = 0.55
    let card: Card
    let userId: UUID
    let myCollectedUtil: CollectedUtil
    let userCollectedUtil: CollectedUtil
    let group = DispatchGroup()
    
    
    init(card: Card, userId: UUID) {
        self.userId = userId
        self.card = card
        self.myCollectedUtil = CollectedUtil(id: myIdGetter()!)
        self.userCollectedUtil = CollectedUtil(id: userId)
    }
    var body: some View {
        if !loginVM.authenticated {
            NotConnectedView()
        } else {
            switch collectionVM.state {
            case .idle:
                Color.clear
                    .onAppear{
                        collectionVM.loadUserCollection(id: nil)
                    }
            case .loading:
                ProgressView()
            case .failed(let error):
                VStack {
                    Text(errorToText(error: error as! NetworkError))
                    Button("Retry") {
                        collectionVM.loadUserCollection(id: nil)
                    }
                }
            case .loaded(let collection):
                
                GeometryReader { metrics in
                    VStack {
                        Button(action:{
                            showingCard.toggle()
                            if showingCard {
                                taux = 1
                            } else {
                                taux = 0.60
                            }
                        },label : {
                            CardView(card: card, taux: taux)
                        })
                        .frame(
                            height: metrics.size.height * taux
                        )
                        Button("Trade"){
                            let myCard = myCollectedUtil.getCollectedCardById(cardId: selectedCard!.card.id)
                            let userCard = userCollectedUtil.getCollectedCardById(cardId: card.id)
                            tradeVM.sendTradeRequest(myId: myIdGetter()!,
                                                     userId: userId,
                                                     myCollectedCard: myCard!,
                                                     userCollectedCard: userCard!)
                            self.mode.wrappedValue.dismiss()
                        }
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(22)
                        Picker(selection: $selectedCard, label: EmptyView()) {
                            ForEach(collection, id: \.self) { card in
                                Text("\(card.card.name)  x\(card.quantity)").tag(card as GroupedCard?)
                            }.onAppear {
                                selectedCard = collection.first
                            }
                        }
                    }
                }
            }
        }
    }
}
