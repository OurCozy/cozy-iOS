//
//  MapResponseString.swift
//  Cozy
//
//  Created by 최은지 on 2020/07/13.
//  Copyright © 2020 jun. All rights reserved.
//

import Foundation
import UIKit

// MARK: - MapResponseString
struct MapResponseString: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: [MapBookStore]?
    
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
        data = (try? values.decode([MapBookStore].self, forKey: .data)) ?? nil
    }
}

struct MapBookStore: Codable {
    var bookstoreIdx: Int
    var sectionIdx: Int
    var bookstoreName: String
    var hashtag1: String
    var hashtag2: String
    var hashtag3: String
    var profile: String
    var image1: String
    var count: Int
    var checked: Int
}
