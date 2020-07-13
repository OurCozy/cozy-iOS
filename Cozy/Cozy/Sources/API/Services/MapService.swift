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
    
    let header: HTTPHeaders = [
        "Content-Type" : "application/json",
        "token" : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWR4IjoxLCJpYXQiOjE1OTQ1NDM5NDIsImV4cCI6My42MzYzNjM2MzYzNjM3OTU0ZSsyMiwiaXNzIjoib3VyLXNvcHQifQ.gIsHK5BvP0CCvz7g2GgGVvREJyvIjaybQTk93xGR5r4"
    ]
    
    // 지역별 서점 조회
    func getMapBookStore(completion: @escaping (NetworkResult<Any>) -> Void){
        
        let myMapURL  = APIConstants.mapURL + "1"
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
        print(decodedData)
        guard let interestData = decodedData.data else { return .requestErr(decodedData.message) }
        print(interestData)
        return .success(interestData)
    }
    
}
