//
//  ProfileData.swift
//  Cozy
//
//  Created by 양지영 on 2020/07/13.
//  Copyright © 2020 jun. All rights reserved.
//

import Foundation

// json 디코딩
struct ProfileData: Codable {
    var status: Int
    var success: Bool
    var message: String
    var data: [UserProfile]?
    
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
            data = (try? values.decode([UserProfile].self, forKey: .data)) ?? nil
        }
    }

// 받아온 객체 디코딩
struct UserProfile: Codable{
    // API랑 변수명 같아야함
        var profile: String
        var nickname: String
        var email: String
        
        init(profile:String, nickname:String, email:String){
            self.profile = profile
            self.nickname = nickname
            self.email = email
        }
}
        
