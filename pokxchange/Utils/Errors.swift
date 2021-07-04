//
//  Errors.swift
//  pokxchange
//
//  Created by abdelillah ghomari on 7/2/21.
//

import Foundation

enum AuthenticationError: Error {
    case invalidCredentials
    case custom(errorMessage: String)
}

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}
