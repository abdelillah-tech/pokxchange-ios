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
    UserWebService().getUserByUsername(token: token, username: username) { result in
        let encoder = JSONEncoder()
        switch result {
        case .success(let user):
            guard let data = try? encoder.encode(user) else { return }
            defaults.set(data, forKey: "me")
            defaults.setValue(token, forKey: "jsonwebtoken")
            DispatchQueue.main.async {
                defaults.setValue(user.id.uuidString, forKey: "myId")
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

func myUserGetter() -> User? {
    let defaults = UserDefaults.standard
    if let objects = defaults.value(forKey: "me") as? Data {
        let decoder = JSONDecoder()
        if let objectsDecoded = try? decoder.decode(User.self, from: objects) as User {
            return objectsDecoded
        } else {
            return nil
        }
    } else {
            return nil
    }
}
