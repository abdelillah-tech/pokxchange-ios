//
//  pokxchangeApp.swift
//  pokxchange
//
//  Created by abdelillah ghomari on 6/8/21.
//

import SwiftUI

@main
struct pokxchangeApp: App {
    @StateObject private var claimVM = ClaimViewModel()
    @State var showClaim: Bool = false
    
    func claimCard(){
        showClaim = claimVM.claim()
        return
    }
    
    var body: some Scene {
        WindowGroup {
            TabView {
                NavigationView {
                    if showClaim {
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
                    }
                    else {
                        CollectionView(id: nil, username: "Pokedex", viewMode: CollectionViewMode.mine)
                    }
                }
                .tabItem {
                    Text("Pokedex")
                    Image("Pokeball")
                }
                
                NavigationView {
                    UsersView()
                }
                .tabItem {
                    Text("Users")
                    Image("Users")
                }
                
                NavigationView {
                    CollectionView(id: nil, username: "Requests", viewMode: CollectionViewMode.requests)
                }
                .tabItem {
                    Text("Trade Requests")
                    Image("Trade")
                }
            
                LoginView()
                .tabItem {
                    Text("Login")
                    Image("Login")
                }
            
                RegisterView()
                .tabItem {
                    Text("Register")
                    Image("Register")
                }
            
                LogoutView()
                .tabItem {
                    Text("Logout")
                    Image("Register")
                }
            }
            .onAppear(perform: claimCard)
        }
    }
}
