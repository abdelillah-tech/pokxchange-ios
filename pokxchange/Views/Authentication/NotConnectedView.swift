//
//  NotConnectedView.swift
//  pokxchange
//
//  Created by abdelillah ghomari on 7/6/21.
//

import SwiftUI

struct NotConnectedView: View {
    @EnvironmentObject private var loginVM: LoginViewModel
    @EnvironmentObject private var registerVM: RegisterViewModel

    @State var changeView = false
    @State var showLogin = false
    @State var showRegister = false
    
    var body: some View {
        VStack {
            if registerVM.created {
                Text("Please connect to your account")
                Button("Login"){
                    showLogin = true
                    showRegister = false
                }
                .foregroundColor(.white)
                .padding()
                .background(Color.blue)
                .cornerRadius(25)
                .sheet(isPresented: $showLogin) {
                    LoginView()
                }
            } else {
                Button("Login"){
                    showLogin = true
                    showRegister = false
                }
                .foregroundColor(.white)
                .padding()
                .background(Color.blue)
                .cornerRadius(25)
                .sheet(isPresented: $showLogin) {
                    LoginView()
                }
                
                Button("Register"){
                    showLogin = false
                    showRegister = true
                }
                .foregroundColor(.white)
                .padding()
                .background(Color.blue)
                .cornerRadius(25)
                .sheet(isPresented: $showRegister) {
                    RegisterView()
                }
            }
        }
    }
}
