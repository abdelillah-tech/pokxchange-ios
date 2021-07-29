//
//  TradePendinItem.swift
//  pokxchange
//
//  Created by abdelillah ghomari on 7/9/21.
//

import Foundation

import SwiftUI

struct TradePendingItemView: View {
    @StateObject private var tradePendingsVM = TradeViewModel()
    let myCard: Card
    let exchangeCard: Card
    let sender: User
    let tradeId: UUID
    
    init(myCard: Card,
         exchangeCard: Card,
         sender: User,
         tradeId: UUID) {
        self.myCard = myCard
        self.exchangeCard = exchangeCard
        self.sender = sender
        self.tradeId = tradeId
    }
    
    var body: some View {
        VStack() {
            Text(sender.username).font(.headline)
            HStack() {
                VStack() {
                    Text("\(myCard.name)").font(.system(size: 15.0))
                    CardIconView(card: myCard)
                }
                
                VStack() {
                    Text("\(exchangeCard.name)").font(.system(size: 15.0))
                    CardIconView(card: exchangeCard)
                }
                Spacer()
                
                Button("✔️"){
                    tradePendingsVM.approveTradeRequest(recipientId: myIdGetter()!,
                                                        tradeId: tradeId)
                    tradePendingsVM.loadTradePendings(id: myIdGetter()!)
                }
                .foregroundColor(.white)
                .padding()
                .background(Color.green)
                .cornerRadius(22)
                .frame(width: 70, height: 40, alignment: .center)
                
                Button("✖️"){
                    tradePendingsVM.cancelTradeRequest(recipientId: myIdGetter()!,
                                                        tradeId: tradeId)
                    tradePendingsVM.loadTradePendings(id: myIdGetter()!)

                }
                .foregroundColor(.white)
                .padding()
                .background(Color.red)
                .cornerRadius(22)
                .frame(width: 70, height: 40, alignment: .center)
            }
            
        }.padding()
    }
}
