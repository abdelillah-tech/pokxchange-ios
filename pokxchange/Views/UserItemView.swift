//
//  UserItemView.swift
//  pokxchange
//
//  Created by abdelillah ghomari on 7/2/21.
//

import SwiftUI

struct UserItemView: View {
    let user: User?
    let viewMode: UsersViewMode
    @StateObject private var UserVM = UserViewModel()


    var body: some View {
        HStack() {
            Text(user!.name).font(.headline)
            if viewMode == UsersViewMode.strangers {
                Spacer()
                Button("Add"){
                    UserVM.sendFriendRequest(id: user!.id)
                }
                .foregroundColor(.white)
                .padding()
                .background(Color.blue)
                .cornerRadius(22)
            }
            if viewMode == UsersViewMode.requests {
                Spacer()
                Button("Approve"){
                    UserVM.approveFriendRequest(id: user!.id)
                }
                .foregroundColor(.white)
                .padding()
                .background(Color.blue)
                .cornerRadius(22)
            }
        }
        .padding()
    }
}

struct UserItemView_Previews: PreviewProvider {
    static var user: User?
    static var viewMode: UsersViewMode = UsersViewMode.strangers

    static var previews: some View {
        UserItemView(user: user, viewMode: viewMode)
    }
}
