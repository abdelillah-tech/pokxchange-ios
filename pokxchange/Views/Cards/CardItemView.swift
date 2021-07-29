//
//  CardItemView.swift
//  pokxchange
//
//  Created by abdelillah ghomari on 7/1/21.
//

import SwiftUI


struct CardItemView: View {
    let card: GroupedCard?
    let viewMode: CollectionViewMode
    var refresh: Bool = false

    var body: some View {
        HStack() {
            CardIconView(card: card?.card)
            Text(card!.card.name).font(.headline)
            if viewMode != CollectionViewMode.all {
                Spacer()
                Text("x\(card!.quantity)")
            }
            if viewMode == CollectionViewMode.friends {
                Spacer()
                Image("Trade")
            }
        }
        .padding()
    }
}

struct CardItemView_Previews: PreviewProvider {
    static var card: GroupedCard?
    static var viewMode: CollectionViewMode = CollectionViewMode.all
    static var previews: some View {
        CardItemView(card: card, viewMode: viewMode)
            .previewLayout(.fixed(width: 400, height: 60))
    }
}
