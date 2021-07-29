//
//  RegisterView.swift
//  pokxchange
//
//  Created by abdelillah ghomari on 6/29/21.
//

import SwiftUI

struct RegisterView: View {
    @EnvironmentObject private var registerVM: RegisterViewModel

    var body: some View {
        VStack {
            Spacer()

            Form {
                TextField("Username", text: $registerVM.username)
                TextField("First name", text: $registerVM.firstName)
                TextField("Last name", text: $registerVM.lastName)
                TextField("Email", text: $registerVM.email)
                SecureField("Password", text: $registerVM.password)
                HStack {
                    Spacer()
                    Button("Register") {
                        registerVM.register()
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
