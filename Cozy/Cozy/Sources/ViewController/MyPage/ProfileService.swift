//
//  ProfileService.swift
//  Cozy
//
//  Created by 양지영 on 2020/07/14.
//  Copyright © 2020 jun. All rights reserved.
//

import Foundation
import Alamofire

struct ProfileService {
static let shared = ProfileService()

    let header: HTTPHeaders = ["Content-Type": "application/json",
    "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWR4IjozLCJuaWNrbmFtZSI6ImdhaW4zIiwiaWF0IjoxNTk0MjM4MzgyLCJleHAiOjE1OTQyNDE5ODIsImlzcyI6Im91ci1zb3B0In0.SsAXN1GGVRduSQLF71Wi5fgwUCslWcscdwK8IvleIvc"
    ]

    func getProfileData(completion: @escaping(NetworkResult<Any>) -> Void) {
        let dataRequest = Alamofire.request(APIConstants.mypageURL, method: .get, encoding:JSONEncoding.default, headers: header)
            
            dataRequest.responseData { dataResponse in
                switch dataResponse.result {
                case .success:
                    guard let statusCode = dataResponse.response?.statusCode else { return }
                    guard let value = dataResponse.result.value else { return }
                    
                    let networkResult = self.judge(by: statusCode, value)
                    
                    completion(networkResult)
                    
                case .failure: completion(.networkFail)
                }
            }
        }
        
        private func judge(by statusCode: Int, _ data: Data) -> NetworkResult<Any> {
            switch statusCode {
            case 200: return isData(by: data)
            case 400: return .pathErr
            case 500: return .serverErr
            default: return .networkFail
            }
        }
        
        private func isData(by data: Data) -> NetworkResult<Any> {
            let decoder = JSONDecoder()
            guard let decodedData = try? decoder.decode(ProfileData.self, from: data) else { return .pathErr }
            print(decodedData)
            guard let interestData = decodedData.data else { return .requestErr(decodedData.message) }
            print(interestData)
            return .success(interestData)
        } }
