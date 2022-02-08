//
//  MyProfileViewModel.swift
//  sesac1
//
//  Created by 경원이 on 2022/02/06.
//

import Foundation
class MyProfileViewModel {
    
    static let shared = MyProfileViewModel()
    
    var myUserInfo: Observable<User> = Observable(User(id: "", v: 0, uid: "", phoneNumber: "", email: "", fcMtoken: "",nick:"쿵짝짝", birth: "", gender: 0, hobby: "abc", comment: [], reputation: [], sesac: 0, sesacCollection: [], background: 0, backgroundCollection: [], purchaseToken: [],transactionID: [],reviewedBefore: [], reportedNum: 0, reportedUser: [], dodgepenalty: 0, dodgeNum: 0, ageMin: 0,ageMax: 0,searchable: 1, createdAt: ""))
    var updateUserModel: Observable<UpdateUserModel> = Observable(UpdateUserModel(searchable: 0, ageMin: 18, ageMax: 65, gender: -1, hobby: ""))
    let repo = Repository()
    var userInfo: User?
    let titleArray = ["좋은 매너", "정확한 시간 약속", "빠른 응답", "친절한 성격", "능숙한 취미 실력", "유익한 시간"]
    var titleBoolArray = [1,0,0,1,1,1]
    
    
    func getSignIn(completion: @escaping (Int?, APIError?, User?) -> Void) {
        repo.getSignIn { code, error, user in
            
            if code == 200 {
                completion(200, nil, user)
                print("유저 정보 가져오기 성공")
            }

            if code == 201 {
                completion(201, nil, user)
                print("미가입유저")
            }

            if code == 401 {
                completion(401, nil, user)
                print("firebase Token Error")

            }

            if code == 500 {
                completion(500, nil, user)
                print("server Error")
            }

            if code == 501 {
                completion(501, nil, user)
                print("header, body 확인 요")
            }
        }
    }
    
    func postUpdateUser(UpdateUserModel: UpdateUserModel, completion: @escaping (Int?, APIError?) -> Void) {
        
        repo.postUserUpdate(UpdateUserModel: UpdateUserModel) { statusCode, error in
            if statusCode == 200 {
                completion(statusCode, nil)
                
            } else {
                completion(statusCode, error)
            }
        }
    }
    
    
    
    private init() {
        
    }
    
    
}
