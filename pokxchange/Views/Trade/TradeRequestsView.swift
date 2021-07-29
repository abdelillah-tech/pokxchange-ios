//
//  TradeRequestsView.swift
//  pokxchange
//
//  Created by abdelillah ghomari on 7/4/21.
//

import SwiftUI

struct TradeRequestsView: View {
    @EnvironmentObject private var loginVM: LoginViewModel
    @StateObject private var tradePendingsVM = TradeViewModel()
    @State var showLogin = false
    @State var showRegister = false
    
    var body: some View {
        if !loginVM.authenticated {
            NotConnectedView()
        } else {
            switch tradePendingsVM.state {
            case .idle:
                Color.clear
                    .onAppear{
                        tradePendingsVM.loadTradePendings(id: myIdGetter()!)
                    }
            case .loading:
                ProgressView()
            case .failed(let error):
                VStack {
                    Text(errorToText(error: error as! NetworkError))
                    Button("Retry") {
                        tradePendingsVM.loadTradePendings(id: myIdGetter()!)
                    }
                }
            case .loaded(let tradePendings):
                List {
                    ForEach(tradePendings, id: \.self) { tradePending in
                        TradePendingItemView(myCard: tradePending.myCard,
                                             exchangeCard: tradePending.exchangeCard,
                                             sender: tradePending.sender,
                                             tradeId: tradePending.tradeId)
                    }
                }
                .navigationTitle("Trade requests")
                .navigationBarTitleDisplayMode(.inline)
                .listStyle(GroupedListStyle())
            }
        }
    }
}

struct TradeRequestsView_Previews: PreviewProvider {
    static var previews: some View {
        TradeRequestsView()
    }
}
