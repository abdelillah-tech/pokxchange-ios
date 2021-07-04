//
//  RegisterView.swift
//  pokxchange
//
//  Created by abdelillah ghomari on 6/29/21.
//

import SwiftUI

struct RegisterView: View {
    @StateObject private var loginVM = LoginViewModel()

    var body: some View {
        VStack {
            Spacer()

            Form {
                TextField("Name", text: $loginVM.username)
                TextField("Username", text: $loginVM.username)
                TextField("Email", text: $loginVM.username)
                SecureField("Password", text: $loginVM.password)
                SecureField("Confirm password", text: $loginVM.password)
            }
            Spacer()

            Button("Register") {
                loginVM.login()
            }.padding()
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
