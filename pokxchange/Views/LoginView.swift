//
//  LoginView.swift
//  pokxchange
//
//  Created by abdelillah ghomari on 6/8/21.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject private var loginVM: LoginViewModel
    @StateObject private var webService = AuthWebService()
    @State private var showMessage = false
    @State private var username = ""
    @State private var password  = ""
    @State private var authenticated = false

    var body: some View {
        VStack {
            Spacer()
            Form {
                HStack {
                    Text(loginVM.authenticated ? "You are connected": "")
                    Spacer()
                    Image(systemName: !loginVM.authenticated ? "lock.fill": "lock.open")
                }
                TextField("Username", text: $loginVM.username)
                SecureField("Password", text: $loginVM.password)
                HStack {
                    Spacer()
                    Button("Login") {
                        loginVM.login()
                    }
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(22)
                    
                    Spacer()
                }
            }.buttonStyle(PlainButtonStyle())
            Spacer()
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
