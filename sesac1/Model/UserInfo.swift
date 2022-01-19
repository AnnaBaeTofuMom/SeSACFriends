//
//  UserInfo.swift
//  sesac1
//
//  Created by 경원이 on 2022/01/20.
//

import Foundation

class UserInfo {
    static let shared = UserInfo()
    var phoneNumber: String?
    var isVerified: Bool?
    var password: String?
    var nickname: String?
    var dateOfBirth: Date?
    var email: String?
    var genderIsMale: Bool?
}
