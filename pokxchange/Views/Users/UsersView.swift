//
//  UsersView.swift
//  pokxchange
//
//  Created by abdelillah ghomari on 6/29/21.
//
enum UsersViewMode {
    case strangers
    case friends
    case requests
}

import SwiftUI

struct UsersView: View {
    @StateObject private var userVM = UserViewModel()
    @EnvironmentObject private var loginVM: LoginViewModel
    @EnvironmentObject private var registerVM: RegisterViewModel
    @State var viewMode: UsersViewMode = UsersViewMode.strangers
    @State var searchText = ""
    @State var searching = false
    @State var showMyFriends = false
    @State var showRequests = false
    
    var body: some View {
        if !loginVM.authenticated {
            NotConnectedView()
        } else {
            switch userVM.state {
            case .idle:
                Color.clear
                    .onAppear {
                        switch viewMode {
                        case UsersViewMode.friends:
                            userVM.loadUsers(id: myIdGetter()!)
                        case UsersViewMode.requests:
                            userVM.getUsersRequests()
                        default:
                            userVM.loadUsers(id: nil)
                        }
                    }
            case .loading:
                ProgressView()
            case .failed( _):
                VStack {
                    Text("Sorry we can't load your community for the moment")
                    Button("Retry") {
                        userVM.loadUsers(id: nil)
                        showMyFriends = false
                        showRequests = false
                    }
                }
            case .loaded(let users):
                
                VStack(alignment: .leading) {
                    SearchBar(searchText: $searchText, searching: $searching)
                    HStack {
                        Button("Friends"){
                            showMyFriends.toggle()
                            showRequests = false
                            viewMode = UsersViewMode.friends
                            userVM.state = .idle
                            if !showRequests && !showMyFriends {
                                userVM.state = .idle
                                viewMode = UsersViewMode.strangers
                            }
                        }
                        .foregroundColor(.white)
                        .padding()
                        .background(isValidColor(state: showMyFriends))
                        .cornerRadius(25)
                        
                        Button("Requests"){
                            showRequests.toggle()
                            showMyFriends = false
                            userVM.state = .idle
                            viewMode = UsersViewMode.requests
                            if !showRequests && !showMyFriends {
                                userVM.state = .idle
                                viewMode = UsersViewMode.strangers
                            }
                        }
                        .foregroundColor(.white)
                        .padding()
                        .background(isValidColor(state: showRequests))
                        .cornerRadius(25)
                    }
                    List {
                        ForEach(users.filter({(user: User) -> Bool in
                            return user.username.lowercased().hasPrefix(searchText.lowercased()) || searchText == ""
                        }), id: \.id) { user in
                            if viewMode == UsersViewMode.friends {
                                NavigationLink(destination: CollectionView(id: user.id, username: user.username, viewMode: CollectionViewMode.friends)) {
                                    UserItemView(user: user, viewMode: viewMode)
                                }
                            } else {
                                UserItemView(user: user, viewMode: viewMode)
                            }
                        }
                    }
                    .navigationBarTitle("")
                    .navigationBarHidden(true)
                    .listStyle(GroupedListStyle())
                }
            }
        }
    }
}

struct UsersView_Previews: PreviewProvider {
    static var previews: some View {
        UsersView()
    }
}
