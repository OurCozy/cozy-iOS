//
//  SigninData.swift
//  Cozy
//
//  Created by 양재욱 on 2020/07/16.
//  Copyright © 2020 jun. All rights reserved.
//

import Foundation

struct SigninData: Codable {
    var status: Int
    var success: Bool
    var message: String
    var data: TokenData?
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case success = "success"
        case message = "message"
        case data = "data"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = (try? values.decode(Int.self, forKey: .status)) ?? -1
        success = (try? values.decode(Bool.self, forKey: .success)) ?? false
        message = (try? values.decode(String.self, forKey: .message)) ?? ""
        data = (try? values.decode(TokenData.self, forKey: .data)) ?? nil
    }
    
}

struct TokenData: Codable {
    var userIdx: Int
    var nickname: String
    var email: String
    var profile: String
    var accessToken: String
    
    init(userIdx:Int, nickname:String, email:String, profile:String, accessToken:String){
        self.userIdx = userIdx
        self.nickname = nickname
        self.email = email
        self.profile = profile
        self.accessToken = accessToken
    }
}
