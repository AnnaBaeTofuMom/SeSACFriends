//
//  PhoneAuthViewModel.swift
//  sesac1
//
//  Created by 경원이 on 2022/01/20.
//

import Foundation
import RxSwift
import RxCocoa
import FirebaseAuth

class PhoneAuthViewModel {
    
    let repo = Repository()
    var phoneNumber: String = ""
    var codeNumber: String = ""
    var authID: String = ""
    var codeAuthorized: Bool = false
    var isMember: Bool = false
    
    
    func modifyNumber(completion: @escaping (APIError?, StatusCode?) -> Void) {
        let actualPhoneNumber = "+82\(phoneNumber.components(separatedBy: ["-"]).joined())"
        
        print("this is actual phone number \(actualPhoneNumber)")
        repo.requestPhoneAuth(phoneNumber: actualPhoneNumber) { error, StatusCode in
            if error == nil {
                completion(.success, .success)
                
            } else {
                completion(.failed, .failed)
                
            }
        }
    }
    
    @objc func verifyCodeNumber() {
        repo.requestCodeAuth(code: codeNumber) { error, statusCode in
            if error == nil {
                print("----ViewModel----this code is verified")
                self.codeAuthorized = true
            } else {
                print("----ViewModel----this code is not verified")
            }
        }
    }
    
    
    
    

    

    
}
