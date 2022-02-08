//
//  SignInViewModel.swift
//  sesac1
//
//  Created by 경원이 on 2022/01/23.
//

import Foundation
import RxSwift
import UIKit
import Rswift

class signInViewModel {
    
    let repo = Repository()
    var phoneNumber: String = ""
    var nickname: String = "Unknown User \(Int.random(in: 1...100))"
    var dateOfBirth: Date = Date()
    var email: String = "Unknown@email.com"
    var gender: Int = 0
    var fcmToken: String? = UserDefaults.standard.string(forKey: "fcmToken")
    
    
    func isContentExist(text: String) -> Bool {
        
        if text.count > 10 {
            return false
        } else if text.count == 0{
            return false
        } else {
            return true
        }
        
    }
    
    func isFocsed(text: String) -> UIColor {
        if text.count > 1 {
            return R.color.gray3()!
        } else {
            return R.color.focus()!
        }
    }
    
    func verifyEmail(text: String) -> Bool {
        let pattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let regex = try? NSRegularExpression(pattern: pattern)
        if let _ = regex?.firstMatch(in: text, options: [], range: NSRange(location: 0, length: text.count)) {
            return true
        }
        return false
    }
    
    func SignUpButtonClicked(completion: @escaping (Int?, APIError?) -> Void ) {
        repo.postSignUp(phoneNumber: self.phoneNumber, nickname: self.nickname, birth: self.dateOfBirth, email: self.email, gender: self.gender) { code, error in
            guard let error = error else {
                print("this is status Code: \(code ?? 000)")
                completion(code, nil)
                return
            }
            completion(code, .failed)
            
            
        }
        
    }
    
    func SignIn(completion: @escaping (Int?, APIError?, User?) -> Void ) {
        
        repo.getSignIn { statusCode, error, user  in
            guard let error = error else {
                if statusCode == 200 {
                    completion(200, nil, user)
                }
                if statusCode == 201 {
                    completion(201, nil, nil)
                    print("미가입유저")
                }
                
                if statusCode == 401 {
                    completion(401, nil, nil)
                    print("firebase Token Error")
                    
                }
                
                if statusCode == 500 {
                    completion(500, nil, nil)
                    print("server Error")
                }
                
                if statusCode == 501 {
                    completion(501, nil, nil)
                    print("header, body 확인 요")
                }
                return
            }

        }
        
        
        
    }
  
}
