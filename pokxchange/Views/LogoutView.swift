//
//  LogoutView.swift
//  pokxchange
//
//  Created by abdelillah ghomari on 7/3/21.
//

import SwiftUI

struct LogoutView: View {
    @StateObject private var loginVM = LoginViewModel()

    var body: some View {
        Button("Logout") {
            loginVM.signout()
        }
        .foregroundColor(.white)
        .padding()
        .background(Color.red)
        .cornerRadius(25)
        
    }
}

struct LogoutView_Previews: PreviewProvider {
    static var previews: some View {
        LogoutView()
    }
}
