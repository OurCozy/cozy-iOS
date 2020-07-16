//
//  recentData.swift
//  Cozy
//
//  Created by 양지영 on 2020/07/16.
//  Copyright © 2020 jun. All rights reserved.
//

import Foundation

// json 디코딩
struct RecentData: Codable {
    var status: Int
    var success: Bool
    var message: String
    var data: [recentBookstore]?
    
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
            data = (try? values.decode([recentBookstore].self, forKey: .data)) ?? nil
        }
    }

// 받아온 객체 디코딩
struct recentBookstore: Codable{
    // API랑 변수명 같아야함
        var bookstoreIdx: Int
        var bookstoreName: String
        var profile: String
        var image1: String
        
    init(bookstoreIdx:Int, bookstoreName:String, profile:String, image1: String){
            self.bookstoreIdx = bookstoreIdx
            self.bookstoreName = bookstoreName
            self.profile = profile
            self.image1 = image1
        }
}
        
