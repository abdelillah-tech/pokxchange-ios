//
//  CardItemView.swift
//  pokxchange
//
//  Created by abdelillah ghomari on 7/1/21.
//

import SwiftUI


struct CardItemView: View {
    let card: Card?
    let viewMode: CollectionViewMode

    var body: some View {
        HStack() {
            CardIconView(card: card)
            Text(card!.name).font(.headline)
            if viewMode == CollectionViewMode.friends {
                Spacer()
                Image("Trade")
            }
            if viewMode == CollectionViewMode.requests {
                Spacer()
                Button("Approve"){
                    TradeWebService().approveTradeRequest(id: card!.id)
                }
                .foregroundColor(.white)
                .padding()
                .background(Color.blue)
                .cornerRadius(22)
            }
        }
        .padding()
    }
}

struct CardItemView_Previews: PreviewProvider {
    static var card: Card?
    static var viewMode: CollectionViewMode = CollectionViewMode.mine
    static var previews: some View {
        CardItemView(card: card, viewMode: viewMode)
            .previewLayout(.fixed(width: 400, height: 60))
    }
}
