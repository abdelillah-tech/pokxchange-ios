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
    @StateObject var loginVM = LoginViewModel()
    @StateObject var registerVM = RegisterViewModel()
    @State var showClaim: Bool = false
    @State var bonusCard: Card?
    
    func claimCard() {
        guard let token = UserDefaults.standard.string(forKey: "jsonwebtoken") else {
            return
        }
        CardWebService().bonus(token: token, id : myIdGetter()) { result in
            switch result {
            case .success(let card):
                DispatchQueue.main.async {
                    bonusCard = card
                    showClaim = true
                }
            case .failure(_):
                DispatchQueue.main.async {
                    bonusCard = nil
                    showClaim = false
                }
            }
        }
    }
    
    var body: some Scene {
        WindowGroup {
            TabView {
                NavigationView {
                    ZStack {
                        CollectionView(id: nil,
                                       username: "Pokedex",
                                       viewMode: CollectionViewMode.all)
                            .blur(radius: showClaim ? 20 : 0)
                        
                        if showClaim {
                            VStack {
                                Button("Close"){
                                    showClaim.toggle()
                                    
                                }.foregroundColor(.white)
                                .padding()
                                .background(Color.red)
                                .cornerRadius(22)
                                CardView(card: bonusCard, taux: 1)
                            }
                        }
                    }
                    .onAppear(perform: claimCard)
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
                    TradeRequestsView()
                }
                .tabItem {
                    Text("Trade Requests")
                    Image("Trade")
                }
                if loginVM.authenticated {
                    LogoutView()
                        .tabItem {
                            Text("Logout")
                            Image("Login")
                        }
                }
            }
            .environmentObject(loginVM)
            .environmentObject(registerVM)
        }
    }
}
