//
//  RegisterViewModel.swift
//  pokxchange
//
//  Created by abdelillah ghomari on 7/9/21.
//

import Foundation

class RegisterViewModel: ObservableObject {
    
    var username: String = ""
    var password: String = ""
    var firstName: String = ""
    var lastName: String = ""
    var email: String = ""
    @Published var created : Bool = false
    
    func register() {
        AuthWebService().register(
            username: username,
            firstName: firstName,
            lastName: lastName,
            email: email,
            password: password) { result in
            
            switch result {
            case .success( _):
                DispatchQueue.main.async {
                    self.created = true
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
