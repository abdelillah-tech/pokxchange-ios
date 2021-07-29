//
//  Errors.swift
//  pokxchange
//
//  Created by abdelillah ghomari on 7/2/21.
//

import Foundation

enum AuthenticationError: Error {
    case invalidCredentials
    case decodingError
    case custom(errorMessage: String)
}

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

func errorToText(error: NetworkError) -> String{
    switch error {
    case .noData:
        return "You have no cards for the moment"
    default:
        return "Sorry we can't list your lovely creatures"
    }
}
