//
//  LogoutView.swift
//  pokxchange
//
//  Created by abdelillah ghomari on 7/3/21.
//

import SwiftUI

struct LogoutView: View {
    @EnvironmentObject private var loginVM: LoginViewModel
    private static let user = myUserGetter()
    
    var body: some View {
        VStack {
            Spacer()
            VStack(alignment: .leading) {
                Text("Username : \(LogoutView.user?.username ?? "")").font(.headline).padding()
                Text("First name : \(LogoutView.user?.firstName ?? "")").font(.headline).padding()
                Text("Last name : \(LogoutView.user?.lastName ?? "")").font(.headline).padding()
            }
            Button("Logout") {
                loginVM.signout()
            }
            .foregroundColor(.white)
            .padding()
            .background(Color.red)
            .cornerRadius(25)
            Spacer()
        }
    }
}

struct LogoutView_Previews: PreviewProvider {
    static var previews: some View {
        LogoutView()
    }
}
