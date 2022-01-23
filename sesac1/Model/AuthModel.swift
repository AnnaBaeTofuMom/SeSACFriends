//
//  AuthModel.swift
//  sesac1
//
//  Created by 경원이 on 2022/01/22.
//

import Foundation

enum APIError : Error {
    case success
    case failed
    case networkError
    case invalidToken
    case invalidLogin
    case noData
}

enum StatusCode : Int {
    case success = 200
    case failed = 400
}


class AuthModel {
    
    let repo = Repository()
    
    
}
