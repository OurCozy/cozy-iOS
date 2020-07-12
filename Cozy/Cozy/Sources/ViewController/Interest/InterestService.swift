//
//  InterestService.swift
//  Cozy
//
//  Created by 양재욱 on 2020/07/10.
//  Copyright © 2020 jun. All rights reserved.
//

import Foundation
import Alamofire

struct InterestService {
    static let shared = InterestService()
    
    let header: HTTPHeaders = ["Content-Type": "application/json", "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWR4IjoxLCJpYXQiOjE1OTQ1MzYwMTIsImV4cCI6My42MzYzNjM2MzYzNjM3OTU0ZSsyMiwiaXNzIjoib3VyLXNvcHQifQ.nxltflO1cRWcc3YpPoou7ELc9_kWLCRWDmMsk_DA3Yc"]
    
    func getBookStoreData(completion: @escaping (NetworkResult<Any>) -> Void) {
        
        let dataRequest = Alamofire.request(APIConstants.interestURL, method: .get, encoding:JSONEncoding.default, headers: header)
        
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
        guard let decodedData = try? decoder.decode(InterestModel.self, from: data) else { return .pathErr }
        print(decodedData)
        guard let interestData = decodedData.data else { return .requestErr(decodedData.message) }

        return .success(interestData)
    } }
