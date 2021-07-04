//
//  UserViewModel.swift
//  pokxchange
//
//  Created by abdelillah ghomari on 7/3/21.
//

import Foundation

class UserViewModel: ObservableObject {
    
    @Published var users = [User]()
    let defaults = UserDefaults.standard
    
    
    func getUsers() {
        guard let token = defaults.string(forKey: "jsonwebtoken") else {
            return
        }
        
        UserWebService().getUsers(token: token) { result in
            switch result {
                case .success(let users):
                    DispatchQueue.main.async {
                        self.users = users
                    }
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
    
    func getFriends() {
        users = UserWebService().getFriends()
    }
    
    func getUsersRequests() {
        //users = UserWebService().getUsersRequests()
    }
    
    func sendFriendRequest(claimerId: UUID, receiverId: UUID) {
        guard let token = defaults.string(forKey: "jsonwebtoken") else {
            return
        }
        UserWebService().sendFriendRequest(token: token,
                                  claimerId: claimerId,
                                  receiverId: receiverId) { result in
            switch result {
                case .success(let state):
                    DispatchQueue.main.async {
                    }
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
    
    func approveFriendRequest(claimerId: UUID, receiverId: UUID) {
        guard let token = defaults.string(forKey: "jsonwebtoken") else {
            return
        }
        
        UserWebService().sendFriendRequest(token: token,
                                  claimerId: claimerId,
                                  receiverId: receiverId) { result in
            switch result {
                case .success(let state):
                    DispatchQueue.main.async {
                    }
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }

}
