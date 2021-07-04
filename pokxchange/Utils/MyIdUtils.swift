//
//  MyIdSetter.swift
//  pokxchange
//
//  Created by abdelillah ghomari on 7/5/21.
//

import Foundation

public func myIdSetter(username: String) {
    let defaults = UserDefaults.standard
    guard let token = defaults.string(forKey: "jsonwebtoken") else {
        return
    }
    UserWebService().getUserIdByUsername(token: token, username: username) { result in
        switch result {
            case .success(let myId):
                defaults.setValue(token, forKey: "jsonwebtoken")
                DispatchQueue.main.async {
                    defaults.setValue(myId.uuidString, forKey: "myId")
                }
            case .failure(let error):
                print(error.localizedDescription)
        }
    }
}

public func myIdGetter() -> UUID? {
    let defaults = UserDefaults.standard
    guard let myId = defaults.string(forKey: "myId") else {
        return nil
    }
    return UUID.init(uuidString: myId)
}
