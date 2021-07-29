//
//  UserViewModel.swift
//  pokxchange
//
//  Created by abdelillah ghomari on 7/3/21.
//

import Foundation

class UserViewModel: ObservableObject {
    
    @Published var users: [User] = []
    @Published var state = LoaderState<User>.idle
    var pending: [FriendshipPending] = []
    
    let group = DispatchGroup()
    
    let defaults = UserDefaults.standard
    
    func loadUsers(id: UUID?) {
        guard let token = defaults.string(forKey: "jsonwebtoken") else {
            return
        }
        UserWebService().loadUsers(token: token, id: id) { [weak self] result in
            switch result {
            case .success(let users):
                DispatchQueue.main.async {
                    self?.users = users
                    self?.state = .loaded(users)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.state = .failed(error)
                }
            }
        }
    }
    
    func getUsers(id: UUID?) {
        guard let token = defaults.string(forKey: "jsonwebtoken") else {
            return
        }
        UserWebService().loadUsers(token: token, id: id) { [weak self] result in
            switch result {
            case .success(let users):
                DispatchQueue.main.async {
                    self?.users = users.filter{user in user.id != myIdGetter()!}
                    self?.state = .loaded(users)
                }
            case .failure(let error):
                self?.state = .failed(error)
            }
        }
    }
    
    func pendingsToUsers(token: String, pendings: [FriendshipPending], completion: @escaping ([User]) -> Void) {
        var pendingUsers: [User] = []
        pendings.forEach { pending in
            group.enter()

            UserWebService().getUserById(token: token, id: pending.claimer) { [weak self] result in
                switch result {
                case .success(let user):
                    pendingUsers.append(user)
                    self?.group.leave()
                case .failure(let error):
                    self?.state = .failed(error)
                }
            }
        }
        group.notify(queue: .main) {
            completion(pendingUsers)
        }
    }
    
    func getAllPendings(token: String, completion: @escaping ([FriendshipPending]) -> Void){
        
        var allPendings: [FriendshipPending] = []
        
        group.enter()
        UserWebService().getUsersRequests(token: token) { [weak self] result in
            switch result {
            case .success(let pendings):
                allPendings = pendings
                self?.group.leave()
            case .failure(let error):
                self?.state = .failed(error)
            }
        }
        group.notify(queue: .main) {
            completion(allPendings)
        }
    }
    
    func getUsersRequests() {
        guard let token = defaults.string(forKey: "jsonwebtoken") else {
            return
        }
        
        self.getAllPendings(token: token) {pendings in
            self.pendingsToUsers(token: token, pendings: pendings) {pendings in
                DispatchQueue.main.async{
                    self.users = pendings
                    self.state = .loaded(pendings)
                }
            }
        }
    }
    
    func sendFriendRequest(claimerId: UUID, receiverId: UUID) {
        guard let token = defaults.string(forKey: "jsonwebtoken") else {
            return
        }
        UserWebService().sendFriendRequest(token: token,
                                           claimerId: claimerId,
                                           receiverId: receiverId) { result in
            switch result {
            case .success( _):
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
        self.getAllPendings(token: token) {pendings in
            let pendingsWithId = pendings.filter { pending in pending.claimer == claimerId }
            UserWebService().approveFriendRequest(token: token,
                                               receiverId: receiverId,
                                               pendingId: pendingsWithId[0].id) { result in
                switch result {
                case .success( _):
                    DispatchQueue.main.async {
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}
