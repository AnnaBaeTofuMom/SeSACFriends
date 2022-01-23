//
//  Repository.swift
//  sesac1
//
//  Created by 경원이 on 2022/01/23.
//
import FirebaseAuth
import RxSwift
import Foundation


class Repository {
    
    
    func requestPhoneAuth(phoneNumber: String, completion: @ escaping (APIError?, StatusCode?) -> Void) {
        print("repo verify phone number")
            PhoneAuthProvider.provider()
                .verifyPhoneNumber(phoneNumber, uiDelegate: nil) { verificationID, error in
                    if let error = error {
                        print("Phone number not verified")
                        print(error.localizedDescription)
                        completion(.failed, .failed)
                        
                        return
                    }
                    
                    print("this is verification ID = \(String(describing: verificationID))")
                    UserDefaults.standard.set(verificationID, forKey: "authVerificationID")
                    completion(nil, .success)
                    
                }
        
        
    }

    func requestCodeAuth(code: String?, completion: @escaping (APIError?, StatusCode?) -> Void ){
        print(#function)
        guard let verificationCode = code else { return }
        let verificationID = UserDefaults.standard.string(forKey: "authVerificationID")!
        let credential = PhoneAuthProvider.provider().credential(
            withVerificationID: verificationID,
            verificationCode: "\(verificationCode)"
        )
        print("this is verificationID \(verificationID)")
        Auth.auth().signIn(with: credential) { authResult, error in
            if error == nil {
                print(authResult ?? "")
                print("User Signed in")
                completion(nil, .success)
                
            } else {
                print(error.debugDescription)
                completion(.failed, nil)
            }
        }
        
    }

}

