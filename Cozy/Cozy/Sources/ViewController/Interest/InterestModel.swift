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
    var data: [BookStoreData]?
    
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
        data = (try? values.decode([BookStoreData].self, forKey: .data)) ?? nil
    }
}

struct BookStoreData: Codable{
    var bookstoreIdx: Int
    var bookstoreName: String
    var image1: String
    var hashtag1: String
    var hashtag2: String
    var hashtag3: String
    var nickname: String
    
    init(bookstoreIdx:Int, bookstoreName:String, image1:String, hashtag1:String, hashtag2:String, hashtag3:String, nickname:String){
        self.bookstoreIdx = bookstoreIdx
        self.bookstoreName = bookstoreName
        self.image1 = image1
        self.hashtag1 = hashtag1
        self.hashtag2 = hashtag2
        self.hashtag3 = hashtag3
        self.nickname = nickname
    }
}
