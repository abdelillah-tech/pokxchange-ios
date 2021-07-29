//
//  Helper.swift
//  pokxchange
//
//  Created by abdelillah ghomari on 7/23/21.
//

import Foundation

enum RequestType{
    case GET, POST, PUT
}

let baseApi = "http://localhost:6000/api" //"https://poke-exchange-api.chukitipok.qtmsheep.com/api"

func buildRequest(token: String?, requestType: RequestType, endpoint: String) -> URLRequest {
        
    let url = URL(string: "\(baseApi)\(endpoint)")!
    
    var request = URLRequest(url: url)
    
    switch requestType {
    case .GET:
        request.httpMethod = "GET"
    case .POST:
        request.httpMethod = "POST"
    case .PUT:
        request.httpMethod = "PUT"
    }
    
    request.setValue("application/json", forHTTPHeaderField: "Accept")
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    
    if token != nil {
        request.addValue("Bearer \(token! as String)", forHTTPHeaderField: "Authorization")
    }
    
    return request
}
