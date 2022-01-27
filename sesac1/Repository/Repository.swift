//
//  Repository.swift
//  sesac1
//
//  Created by 경원이 on 2022/01/23.
//
import FirebaseAuth
import RxSwift
import Foundation
import Alamofire
import SwiftyJSON


class Repository {
    
    let baseURL = "http://test.monocoding.com:35484"
    
    let urlUser = "/user"
    
    
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
    
    func postSignUp(phoneNumber: String, nickname: String, birth: Date, email: String, gender: Int, completion: @escaping (Int?, APIError?) -> Void ) {
        
        let params = [
            "phoneNumber": phoneNumber,
            "FCMtoken": "\(UserDefaults.standard.string(forKey: "fcmToken") ?? "none")",
            "nick": nickname,
            "birth": birth,
            "email": email,
            "gender": gender
        ] as Parameters
        
        let headers = [
            "idtoken": "\(UserDefaults.standard.string(forKey: "idToken") ?? "none")",
            "Content-Type": "application/x-www-form-urlencoded"
        ] as HTTPHeaders
        
        AF.request(baseURL + urlUser, method: .post, parameters: params, headers: headers).validate().responseString { response in
            print("SignUp Response")
            print(response.response!)
            print("this is status code")
            print(response.response?.statusCode as Any)
            completion(response.response?.statusCode, nil)

        }
        
    }
    
    func getSignIn(idToken: String) {
        
        let headers = [
            "idtoken": "\(UserDefaults.standard.string(forKey: "idToken") ?? "none")",
            "Content-Type": "application/x-www-form-urlencoded"
        ] as HTTPHeaders
        
        AF.request(baseURL + urlUser, method: .get, headers: headers).validate().response
        
    }

}

