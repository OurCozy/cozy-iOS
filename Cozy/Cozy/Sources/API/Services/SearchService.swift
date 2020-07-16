//
//  SearchService.swift
//  Cozy
//
//  Created by 최은지 on 2020/07/17.
//  Copyright © 2020 jun. All rights reserved.
//

import Foundation
import Alamofire

struct SearchService {
    static let shared = SearchService()
    
    let header: HTTPHeaders = [
        "Content-Type" : "application/json",
        "token" : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWR4IjoxLCJpYXQiOjE1OTQ1NDM5NDIsImV4cCI6My42MzYzNjM2MzYzNjM3OTU0ZSsyMiwiaXNzIjoib3VyLXNvcHQifQ.gIsHK5BvP0CCvz7g2GgGVvREJyvIjaybQTk93xGR5r4"
    ]
    
    // MARK : 검색별 서점 조회
    func searchBookStore(searchRegion: String, completiton: @escaping (NetworkResult<Any>) -> Void) {
        
        let encodedRegion = makeStringKoreanEncoded(searchRegion)
        let searchURL = APIConstants.searchURL + searchRegion
        
        let dataRequest = Alamofire.request(searchURL, method: .get, encoding: JSONEncoding.default, headers: header)
        
        dataRequest.responseData { dataResponse in
            switch dataResponse.result {
            case .success :
                guard let statusCode = dataResponse.response?.statusCode else { return }
                guard let value = dataResponse.result.value else { return }
                let networkResult = self.judge(by: statusCode, value)
                completiton(networkResult)
                print("success")
            case .failure :
                completiton(.networkFail)
                print("failure")
            }
        }
    }
    
    // MARK : 한글 인코딩
    func makeStringKoreanEncoded(_ string: String) -> String {
        return string.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) ?? string
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
