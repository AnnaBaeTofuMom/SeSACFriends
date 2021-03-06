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
    let urlUserUpdate = "/user/update/mypage"
    let urlQueue = "/queue/onqueue"
    
    
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

    func requestCodeAuth(code: String?, completion: @escaping (APIError?, AuthDataResult?) -> Void ){
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
                completion(nil, authResult)
                
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
    
    func getSignIn(completion: @escaping (Int?, APIError?, User?) -> Void) {
        
        let headers = [
            "idtoken": "\(UserDefaults.standard.string(forKey: "idToken") ?? "none")",
            "Content-Type": "application/x-www-form-urlencoded"
        ] as HTTPHeaders
        
        AF.request(baseURL + urlUser, method: .get, headers: headers).validate().responseJSON { response in
            
            switch response.result {
            case .success(let value):
                if let json = value as? NSDictionary {
                    
                    do {
                        let dataJSON = try JSONSerialization.data(withJSONObject: value, options: .prettyPrinted)
                        
                        
                        let getData = try JSONDecoder().decode(User.self, from: dataJSON)
                        
                        completion(response.response?.statusCode, nil, getData)
                        print(getData)
                        
                    } catch {
                        print(error.localizedDescription)
                        completion(response.response?.statusCode, .failed, nil)
                    }
                    
                    
                }
                
            case .failure(let error):
                print(error)
            }
            
        }
        
    }
    
    func postUserUpdate(UpdateUserModel: UpdateUserModel, completion: @escaping (Int?, APIError?) -> Void) {
        
        let headers = [
            "idtoken": "\(UserDefaults.standard.string(forKey: "idToken") ?? "none")",
            "Content-Type": "application/x-www-form-urlencoded"
        ] as HTTPHeaders
        
        let params = [
            "searchable" : UpdateUserModel.searchable,
            "ageMin" : UpdateUserModel.ageMin,
            "ageMax" : UpdateUserModel.ageMax,
            "gender" : UpdateUserModel.gender,
            "hobby" : "\(UpdateUserModel.hobby!)"
        ] as Parameters
        
        AF.request(baseURL + urlUserUpdate, method: .post, parameters: params, headers: headers).validate().responseString { response in
            switch response.result {
            case .success(let value):
                print("this is update result - success")
                print(value)
                completion(response.response?.statusCode, nil)
            case .failure(let error):
                print("this is update result - failure")
                print(error)
                completion(nil, .failed)
            }
        }
        
        
        
        
        
        
    }
    
    func postQueue(genderType: Int, region: Int, long: Double, lat: Double, hobbyArray: [String], completion: @escaping (Int?, APIError?, NearSeSAC?) -> Void) {
        
        let headers = [
            "idtoken": "\(UserDefaults.standard.string(forKey: "idToken") ?? "none")",
            "Content-Type": "application/x-www-form-urlencoded"
        ] as HTTPHeaders
        
        let params  = [
             "region": region,
             "long": long,
             "lat": lat
        ] as Parameters
        
        AF.request(baseURL + urlQueue, method: .post, parameters: params, headers: headers).responseDecodable(of: NearSeSAC.self ) { response in
            
            if response.response?.statusCode == 200 {
                
                completion(200, nil, response.value)
            }
            
            
            
            
        }
        

        
    }
    
}



