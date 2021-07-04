//
//  LoginViewModel.swift
//  pokxchange
//
//  Created by abdelillah ghomari on 6/9/21.
//

import Foundation


class LoginViewModel: ObservableObject {
    
    var username: String = ""
    var password: String = ""
    @Published var isAuthenticated: Bool = false
    
    func login() {
        
        let defaults = UserDefaults.standard
        
        AuthWebService().login(username: username, password: password) { result in
            switch result {
                case .success(let token):
                    defaults.setValue(token, forKey: "jsonwebtoken")
                    DispatchQueue.main.async {
                        self.isAuthenticated = true
                    }
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
    
    func signout() {
           
           let defaults = UserDefaults.standard
           defaults.removeObject(forKey: "jsonwebtoken")
           DispatchQueue.main.async {
               self.isAuthenticated = false
           }
           
       }
    
}
