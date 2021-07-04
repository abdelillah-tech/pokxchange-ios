//
//  CardView.swift
//  pokxchange
//
//  Created by abdelillah ghomari on 7/2/21.
//

import SwiftUI

struct CustomText: View {
    let text: String
    let size: CGFloat
    var body: some View {
        Text(text)
            .font(Font.system(size:size, design: .default))
    }
}

struct CardView: View {
    let card: Card?
    let width: CGFloat = 300
    let taux: CGFloat
    
    var body: some View {
        VStack {
            HStack {
                CustomText(text: card!.name,size: 30 * taux)
                    .padding(.horizontal)
                Spacer()
                CustomText(text: "x0",size: 30 * taux)
                    .padding(.horizontal)
            }
            RemoteImage(url: card!.imageUrl)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: width * taux)
            Spacer()

            HStack {
                HStack {
                    CustomText(text: "Height:",size:15 * taux)
                    CustomText(text: "23",size:15 * taux)
                }
                HStack {
                    CustomText(text: "Weight:",size:15 * taux)
                    CustomText(text: "50",size:15 * taux)
                }
                HStack {
                    CustomText(text: "Health:",size:15 * taux)
                    CustomText(text: "***",size:15 * taux)
                }
            }
            Spacer()

        }
        .aspectRatio(0.75, contentMode: .fit)
        .frame(maxHeight: .infinity,alignment: .center)
        .background(Color(hex: card!.color))
        .cornerRadius(20)
        .overlay(RoundedRectangle(cornerRadius: 20)
                    .stroke(rarityColor(rarity: card!.rarity), lineWidth: 10))
        .shadow(radius: 20)
        .padding(.all, 10)
    }
}

struct CardView_Previews: PreviewProvider {
    static var card: Card?
    static var taux: CGFloat = 1
    static var previews: some View {
        CardView(card: card, taux: taux)
    }
}

