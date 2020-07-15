//
//  DetailReviewModel.swift
//  Cozy
//
//  Created by IJ . on 2020/07/15.
//  Copyright © 2020 jun. All rights reserved.
//

import Foundation


struct DetailReviewModel: Codable {
    
    struct ReviewData: Codable {
        let reviewIdx, userIdx, bookstoreIdx: Int
        let content, photo: String
        let stars: Int
        let createdAt: String
    }
    
    let status: Int
    let success: Bool
    let message: String
    let data: [ReviewData]?
    
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
        data = (try? values.decode([ReviewData].self, forKey: .data)) ?? nil
    }
}
