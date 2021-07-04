//
//  LoginView.swift
//  pokxchange
//
//  Created by abdelillah ghomari on 6/8/21.
//

import SwiftUI

struct LoginView: View {
    @StateObject private var loginVM = LoginViewModel()

    var body: some View {
        VStack {
            Spacer()
            Form {
                TextField("Username", text: $loginVM.username)
                SecureField("Password", text: $loginVM.password)
            }
            Spacer()
            Button("Login") {
                loginVM.login()
            }
            .padding()
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
