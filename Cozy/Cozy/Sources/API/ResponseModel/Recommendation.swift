//
//  Recommendation.swift
//  Cozy
//
//  Created by IJ . on 2020/07/14.
//  Copyright © 2020 jun. All rights reserved.
//

import Foundation


struct Recommendation: Codable {
    
    struct RecommendationData: Codable {
        let bookstoreIdx: Int
        let profile: String
        let shortIntro: String
        let shortIntro2: String
        let bookstoreName: String
        let location: String
    }
    
    let status: Int
    let success: Bool
    let message: String
    let data: [RecommendationData]?
    
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
        data = (try? values.decode([RecommendationData].self, forKey: .data)) ?? nil
    }
}


