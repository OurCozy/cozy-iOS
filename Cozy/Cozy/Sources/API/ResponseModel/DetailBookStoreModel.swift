//
//  DetailBookStoreModel.swift
//  Cozy
//
//  Created by IJ . on 2020/07/14.
//  Copyright © 2020 jun. All rights reserved.
//

import Foundation

struct DetailBookStoreModel: Codable {
    
    struct BookData: Codable {
        let bookstoreIdx: Int
        let bookstoreName: String
        let latitude: Float
        let longitude: Float
        let location: String
        let sectionIdx: Int
        let tel: String
        let instagram: String
        let facebook: String
        let homepage: String
        let time: String
        let dayoff: String
        let changeable: String
        let activity: String
        let shortIntro: String
        let shortIntro2: String
        let description: String
        let bookmark: Int
        let profile: String
        let hashtag1: String
        let hashtag2: String
        let hashtag3: String
        let image1: String
        let image2: String
        let image3: String
        let checked: Int
    }
    
    let status: Int
    let success: Bool
    let message: String
    let data: [BookData]?
    
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
        data = (try? values.decode([BookData].self, forKey: .data)) ?? nil
    }
}
