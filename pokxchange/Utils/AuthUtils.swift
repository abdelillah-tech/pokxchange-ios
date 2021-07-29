//
//  AuthUtils.swift
//  pokxchange
//
//  Created by abdelillah ghomari on 7/6/21.
//

import Foundation

func isAuthenticated() -> Bool {
    let defaults = UserDefaults.standard
    guard defaults.string(forKey: "jsonwebtoken") != nil else {
        return false
    }
    return true
}
