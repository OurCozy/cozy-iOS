//
//  recentService.swift
//  Cozy
//
//  Created by 양지영 on 2020/07/16.
//  Copyright © 2020 jun. All rights reserved.
//

import Foundation
import Alamofire

struct RecentService {
    static let shared = RecentService()

    // request header 생성
    let header: HTTPHeaders = ["Content-Type": "application/json",
    "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWR4IjoyMCwiaWF0IjoxNTk0OTA3MDUwLCJleHAiOjE1OTQ5NDMwNTAsImlzcyI6Im91ci1zb3B0In0._3Q4-RPpF4ufWyCM4NjEBkRkdMx3tuUIVVqS5qwiCfY"
        //eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWR4IjoyMCwiaWF0IjoxNTk0OTA3MDUwLCJleHAiOjE1OTQ5NDMwNTAsImlzcyI6Im91ci1zb3B0In0._3Q4-RPpF4ufWyCM4NjEBkRkdMx3tuUIVVqS5qwiCfY
    ]

    func getRecentData(completion: @escaping(NetworkResult<Any>) -> Void) {
        // 원하는 형식의 http request 생성
        let dataRequest = Alamofire.request(APIConstants.recentURL, method: .get, encoding:JSONEncoding.default, headers: header)
            
            // 데이터 통신 시작
            dataRequest.responseData { dataResponse in
                switch dataResponse.result {
                case .success:
                    guard let statusCode = dataResponse.response?.statusCode else { return }
                    guard let value = dataResponse.result.value else { return }
                    
                    print("리센트 통신 진입은 성공")
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
        
    // 데이터 통신 성공한 경우, json 타입 decoding 실행한 후 값 확인
        private func isData(by data: Data) -> NetworkResult<Any> {
            let decoder = JSONDecoder()
            guard let decodedData = try? decoder.decode(RecentData.self, from: data) else { print("디코딩 실패")
                return .pathErr }
            print("리센트 디코딩 isData\(decodedData)")
            guard let recentData = decodedData.data else { return .requestErr(decodedData.message) }
            print(recentData)
            return .success(recentData)
        } }
