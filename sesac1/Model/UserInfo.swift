//
//  UserInfo.swift
//  sesac1
//
//  Created by 경원이 on 2022/02/08.
//

import Foundation

class UserInfo {
    
    static let shared = UserInfo()
    
    var user: User?
    
    private init() {
        
    }
    
    
}
