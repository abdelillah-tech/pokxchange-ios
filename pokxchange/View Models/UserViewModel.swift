//
//  UserViewModel.swift
//  pokxchange
//
//  Created by abdelillah ghomari on 7/3/21.
//

import Foundation

class UserViewModel: ObservableObject {
    
    @Published var users = [User]()
    
    func getUsers() {
        users = UserWebService().getUsers()
    }
    
    func getFriends() {
        users = UserWebService().getFriends()
    }
    
    func getUsersRequests() {
        users = UserWebService().getUsersRequests()
    }
    
    func sendFriendRequest(id: Int) {
        _ = UserWebService().sendFriendRequest(id: id)
    }
    
    func approveFriendRequest(id: Int) {
        _ = UserWebService().approveFriendRequest(id: id)
    }

}
