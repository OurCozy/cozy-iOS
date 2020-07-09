//
//  InterestModel.swift
//  Cozy
//
//  Created by 양재욱 on 2020/07/09.
//  Copyright © 2020 jun. All rights reserved.
//

import Foundation

struct InterestModel: Codable{
    var status:Int
    var success: Bool
    var message: String
    var data: [BookStoreServer]?
    
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
        data = (try? values.decode([BookStoreServer].self, forKey: .data)) ?? nil
    }
}

struct BookStoreServer: Codable{
    var bookstoreIdx: Int
    var bookstoreName: String
    var profile: String
    var hashtag: String
}
