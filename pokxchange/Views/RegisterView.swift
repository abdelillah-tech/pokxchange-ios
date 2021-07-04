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
                TextField("Username", text: $loginVM.username)
                TextField("First name", text: $loginVM.username)
                TextField("Last name", text: $loginVM.username)
                TextField("Email", text: $loginVM.username)
                SecureField("Password", text: $loginVM.password)
                SecureField("Confirm password", text: $loginVM.password)
                HStack {
                    Spacer()
                    Button("Register") {
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

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
