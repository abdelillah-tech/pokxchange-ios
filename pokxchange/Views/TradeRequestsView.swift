//
//  TradeRequestsView.swift
//  pokxchange
//
//  Created by abdelillah ghomari on 7/4/21.
//

import SwiftUI

struct TradeRequestsView: View {
    @EnvironmentObject private var loginVM: LoginViewModel
    var body: some View {
        if loginVM.authenticated {
            NavigationView {
                CollectionView(id: nil, username: "Requests", viewMode: CollectionViewMode.requests)
            }

        } else {
            LoginView()
        }
    }
}

struct TradeRequestsView_Previews: PreviewProvider {
    static var previews: some View {
        TradeRequestsView()
    }
}
