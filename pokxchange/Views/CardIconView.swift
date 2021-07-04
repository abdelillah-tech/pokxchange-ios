//
//  CardIconView.swift
//  pokxchange
//
//  Created by abdelillah ghomari on 7/3/21.
//

import Foundation

import SwiftUI

struct CardIconView: View {
    let card: Card?
    var body: some View {
        VStack {
            VStack {
                RemoteImage(url: card!.image)
                        .aspectRatio(contentMode: .fit)
                    .frame(width: 40)

            }.padding()
        }
        .frame(maxWidth: 40, maxHeight: 60, alignment: .center)
        .background(Color(hex: card!.color))
        .cornerRadius(5)
        .overlay(RoundedRectangle(cornerRadius: 5)
                    .stroke(rarityColor(rarity: card!.rarity), lineWidth: 5))
    }
}
