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
    @StateObject private var UserVM = UserViewModel()
    @StateObject private var loginVM = LoginViewModel()
    @State var viewMode: UsersViewMode = UsersViewMode.strangers
    @State var searchText = ""
    @State var searching = false
    @State var showMyFriends = false
    @State var showRequests = false

    func isValidColor(state: Bool) -> Color{
        if state {
            return Color.blue
        }
        return Color.gray
    }
    
    var body: some View {
        if true {
            VStack(alignment: .leading) {
                SearchBar(searchText: $searchText, searching: $searching)
                HStack {
                    Button("Friends"){
                        UserVM.getFriends()
                        viewMode = UsersViewMode.friends
                        showMyFriends.toggle()
                        showRequests = false
                        if !showRequests && !showMyFriends {
                            UserVM.getUsers()
                            viewMode = UsersViewMode.strangers
                        }
                    }
                    .foregroundColor(.white)
                    .padding()
                    .background(isValidColor(state: showMyFriends))
                    .cornerRadius(25)
                    
                    Button("Requests"){
                        UserVM.getUsersRequests()
                        showRequests.toggle()
                        showMyFriends = false
                        viewMode = UsersViewMode.requests
                        if !showRequests && !showMyFriends {
                            UserVM.getUsers()
                            viewMode = UsersViewMode.strangers
                        }
                    }
                    .foregroundColor(.white)
                    .padding()
                    .background(isValidColor(state: showRequests))
                    .cornerRadius(25)
                }
                List {
                    ForEach(UserVM.users.filter({ (user: User) -> Bool in
                        return user.name.lowercased().hasPrefix(searchText.lowercased()) || searchText == ""
                    }), id: \.id) { user in
                        if viewMode == UsersViewMode.friends {
                            NavigationLink(destination: CollectionView(id: user.id, username: user.name, viewMode: CollectionViewMode.friends)) {
                                UserItemView(user: user, viewMode: viewMode)
                            }
                        } else {
                            UserItemView(user: user, viewMode: viewMode)
                        }
                    }
                }.onAppear {
                    if viewMode == UsersViewMode.friends {
                        UserVM.getFriends()
                    } else {
                        UserVM.getUsers()
                    }
                }
                .navigationBarTitle("")
                .navigationBarHidden(true)
                .listStyle(GroupedListStyle())
            }
        } else {
            Text("Please login to enjoy the totality of Pokxchage features")
        }
    }
}

struct UsersView_Previews: PreviewProvider {
    static var previews: some View {
        UsersView()
    }
}
