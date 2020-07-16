//
//  MapService.swift
//  Cozy
//
//  Created by 최은지 on 2020/07/13.
//  Copyright © 2020 jun. All rights reserved.
//

import Foundation
import Alamofire

struct MapService {
    static let shared = MapService()
    
//    let header: HTTPHeaders = [
//        "Content-Type" : "application/json",
//        "token" : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWR4IjoxMSwiaWF0IjoxNTk0OTI1NjI1LCJleHAiOjE1OTQ5NjE2MjUsImlzcyI6Im91ci1zb3B0In0.Z36KA6mimPQIJ1ABEfT3-du9EHo2mqh6XY9kUYhODOw"
//    ]
    
    // 지역별 서점 조회
    func getMapBookStore(mapIdx: Int, completion: @escaping (NetworkResult<Any>) -> Void){
        
        guard let token = UserDefaults.standard.string(forKey: "token") else {return}
        let header: HTTPHeaders = ["Content-Type": "application/json", "token": token]
        
        let myMapURL  = APIConstants.mapURL + String(mapIdx)
        let dataRequest = Alamofire.request(myMapURL, method: .get, encoding: JSONEncoding.default, headers: header)
        
        dataRequest.responseData { dataResponse in
            switch dataResponse.result {
            case .success :
                guard let statusCode = dataResponse.response?.statusCode else { return }
                guard let value = dataResponse.result.value else { return }
                let networkResult = self.judge(by: statusCode, value)
                completion(networkResult)
                print("success")
            case .failure :
                completion(.networkFail)
                print("failure")
            }
        }
    }
    
    // 통신 분기 처리
    private func judge(by statusCode: Int, _ data: Data) -> NetworkResult<Any> {
        switch statusCode {
        case 200: return isData(by: data)
        case 400: return .pathErr
        case 500: return .serverErr
        default: return .networkFail
        }
    }
    
    // json decoding
    private func isData(by data: Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(MapResponseString.self, from: data) else { return .pathErr }
        guard let interestData = decodedData.data else { return .requestErr(decodedData.message) }
        return .success(interestData)
    }
    
}
