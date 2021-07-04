//
//  pokxchangeApp.swift
//  pokxchange
//
//  Created by abdelillah ghomari on 6/8/21.
//

import SwiftUI
import Network

@main
struct pokxchangeApp: App {
    @StateObject private var claimVM = ClaimViewModel()
    @StateObject var loginVM = LoginViewModel()
    @State var showClaim: Bool = false
    
    
    func claimCard(){
        showClaim = claimVM.claim(authenticated: true)
        return
    }
    
    var body: some Scene {
        
        WindowGroup {
            TabView {
                if loginVM.authenticated && showClaim {
                    VStack{
                        Spacer()
                        Button("Close card") {
                            showClaim.toggle()
                        }
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.red)
                        .cornerRadius(22)
                        Spacer()
                        CardView(card: claimVM.card, taux: 1)
                    }
                    .tabItem {
                        Text("Pokedex")
                        Image("Pokeball")
                    }
                } else {
                    NavigationView {
                        CollectionView(id: nil,
                                       username: "Pokedex",
                                       viewMode: CollectionViewMode.mine)
                    }
                    .tabItem {
                        Text("Pokedex")
                        Image("Pokeball")
                    }
                }
                
                if loginVM.authenticated {
                    NavigationView {
                        UsersView()
                    }
                    .tabItem {
                        Text("Users")
                        Image("Users")
                    }
                } else {
                    LoginView()
                    .tabItem {
                        Text("Users")
                        Image("Users")
                    }
                    
                }
                
                if loginVM.authenticated {
                    TradeRequestsView()
                    .tabItem {
                        Text("Trade Requests")
                        Image("Trade")
                    }
                } else {
                    LoginView()
                    .tabItem {
                        Text("Trade Requests")
                        Image("Trade")
                    }
                    
                }
            
                RegisterView()
                .tabItem {
                    Text("Register")
                    Image("Register")
                }
            
                if loginVM.authenticated {
                    LogoutView()
                    .tabItem {
                        Text("Logout")
                        Image("Login")
                    }
                }
            }
            .onAppear(perform: claimCard)
            .environmentObject(loginVM)
        }
    }
}
