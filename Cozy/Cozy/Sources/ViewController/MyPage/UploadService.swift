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
        
        
//        Alamofire.upload( multipartFormData: { multipartFormData in
//
//        })
    }
    
    
    
}
