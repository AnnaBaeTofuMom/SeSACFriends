//
//  SignInViewModel.swift
//  sesac1
//
//  Created by 경원이 on 2022/01/23.
//

import Foundation
import RxSwift

class signInViewModel {
    var nickname: String = "Unknown User \(Int.random(in: 1...100))"
    var dateOfBirth: Date = Date()
    var email: String = "Unknown@email.com"
    var gender: Int = 0
    
    
    func verifyNickname(text: String) -> Bool {
        
        if text.count > 10 {
            return false
        } else if text.count == 0{
            return false
        } else {
            return true
        }
        
    }
    
}
