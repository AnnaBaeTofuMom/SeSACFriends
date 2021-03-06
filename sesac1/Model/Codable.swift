// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let user = try? newJSONDecoder().decode(User.self, from: jsonData)

import Foundation

struct User: Codable {
    let id: String
    let v: Int
    let uid, phoneNumber, email, fcMtoken: String
    let nick, birth: String
    var gender: Int
    let hobby: String
    let comment: [String]
    let reputation: [Int]
    let sesac: Int
    let sesacCollection: [Int]
    let background: Int
    let backgroundCollection: [Int]
    let purchaseToken, transactionID, reviewedBefore: [String]
    let reportedNum: Int
    let reportedUser: [String]
    let dodgepenalty, dodgeNum, ageMin, ageMax: Int
    let searchable: Int
    let createdAt: String
    
    enum CodingKeys: String, CodingKey {
            case id = "_id"
            case v = "__v"
            case uid, phoneNumber, email
            case fcMtoken = "FCMtoken"
            case nick, birth, gender, hobby, comment, reputation, sesac, sesacCollection, background, backgroundCollection, purchaseToken
            case transactionID = "transactionId"
            case reviewedBefore, reportedNum, reportedUser, dodgepenalty, dodgeNum, ageMin, ageMax, searchable, createdAt
        }

}

// MARK: - Welcome
struct NearSeSAC: Codable {
    let fromQueueDB, fromQueueDBRequested: [FromQueueDB]
    let fromRecommend: [String]
}

// MARK: - FromQueueDB
struct FromQueueDB: Codable {
    let uid, nick: String
    let lat, long: Double
    let reputation: [Int]
    let hf, reviews: [String]
    let gender, type, sesac, background: Int
}
