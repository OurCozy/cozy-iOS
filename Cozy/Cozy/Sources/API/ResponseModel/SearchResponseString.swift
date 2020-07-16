//
//  SearchResponseString.swift
//  Cozy
//
//  Created by 최은지 on 2020/07/17.
//  Copyright © 2020 jun. All rights reserved.
//

import Foundation
import UIKit

struct SearchResponseString : Codable{
    let status: Int
    let success: Bool
    let message: String
    let data: [SearchBookStore]?
    
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
        data = (try? values.decode([SearchBookStore].self, forKey: .data)) ?? nil
    }
}

struct SearchBookStore: Codable {
    var bookstoreIdx: Int
    var bookstoreName: String
    var latitude: Double
    var longitude: Double
    var location: String
    var sectionIdx: Int
    var tel: String
    var instagram: String
    var facebook: String
    var homepage: String
    var time: String
    var dayoff: String
    var changeable: String
    var activity: String
    var shortIntro: String
    var shortIntro2: String
    var description: String
    var bookmark: Int
    var profile: String
    var hashtag1: String
    var hashtag2: String
    var hashtag3: String
    var image1: String
}
