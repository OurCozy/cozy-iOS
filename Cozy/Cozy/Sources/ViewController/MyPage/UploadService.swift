//
//  UploadService.swift
//  Cozy
//
//  Created by 양지영 on 2020/07/13.
//  Copyright © 2020 jun. All rights reserved.
//

import Foundation
import Alamofire

struct UploadService {
    static let shared = UploadService()
    
    func uploadImage(_ token: String, _ image: UIImage, _ imageName: String, completion: @escaping (NetworkResult<Any>) -> Void) {
        let headers: HTTPHeaders = ["Content-Type": "multipart/form-data",
        "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWR4IjozLCJuaWNrbmFtZSI6ImdhaW4zIiwiaWF0IjoxNTk0MTI0Mzk2LCJleHAiOjE1OTQxMjc5OTYsImlzcyI6Im91ci1zb3B0In0.2ARNPcK3_Qr7KsA9fH-sRbNCwOJ-Vqxy72-2u_ZGCGM"
        ]
        
//        Alamofire.upload( multipartFormData: { multipartFormData in
//
//        })
    }
    
    
    
}
