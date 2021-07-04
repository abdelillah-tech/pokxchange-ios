//
//  TradeView.swift
//  pokxchange
//
//  Created by abdelillah ghomari on 6/29/21.
//

import SwiftUI

struct TradeView: View {
    @State private var selectedCardIndex = 0
    @State private var showingCard: Bool = false
    @State private var taux: CGFloat = 0.55
    let card: Card?
    @StateObject private var collectionVM = CollectionViewModel()

    
    var body: some View {
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
                    
                }
                .foregroundColor(.white)
                .padding()
                .background(Color.blue)
                .cornerRadius(22)
                Picker(selection: $selectedCardIndex, label: EmptyView()) {
                    ForEach(collectionVM.collection, id: \.id) { card in
                        Text(card.name)
                    }
                }
                
            }
        }.onAppear{
            collectionVM.getMyCollection()
        }
    }
}

struct TradeView_Previews: PreviewProvider {
    static var card: Card?
    static var previews: some View {
        TradeView(card: card)
    }
}
