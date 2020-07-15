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
    
    let header: HTTPHeaders = ["Content-Type": "application/json", "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWR4IjoxMSwiaWF0IjoxNTk0ODAyNjYzLCJleHAiOjE1OTQ4Mzg2NjMsImlzcyI6Im91ci1zb3B0In0.sCBhERO7GwM6GpR54Y1HO7-fSNxs5gB6ufnJhjq0bJw"]
    
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
    
    func putBookStoreData(completion: @escaping (NetworkResult<Any>) -> Void) {
        let idx: String = "3"
        
        let dataRequest = Alamofire.request(APIConstants.interestURL+"/"+idx, method: .put, encoding:JSONEncoding.default, headers: header)
        
        dataRequest.responseData { dataResponse in
            switch dataResponse.result {
            case .success:
                guard let statusCode = dataResponse.response?.statusCode else { return }
                guard let value = dataResponse.result.value else { return }
                print(value)
                
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
    }
    
    private func judge2(by statusCode: Int, _ data: Data) -> NetworkResult<Any> {
        switch statusCode {
        case 200: return isData(by: data)
        case 400: return .pathErr
        case 500: return .serverErr
        default: return .networkFail
        }
    }
    
    private func isData2(by data: Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(PutData.self, from: data) else { return .pathErr }
        print(decodedData)
        guard let putData = decodedData.data else { return .requestErr(decodedData.message) }

        return .success(putData.checked)
    }
    
}
