//
//  APIConstants.swift
//  Cozy
//
//  Created by 양재욱 on 2020/07/09.
//  Copyright © 2020 jun. All rights reserved.
//

import Foundation

struct APIConstants{
    static let baseURL = "http://13.209.107.188:3000"
    static let signupURL = APIConstants.baseURL + "/user/signup"
    static let signinURL = APIConstants.baseURL + "/user/signin"
    static let mainRecommendationURL = APIConstants.baseURL + "/main/recommendation"
    static let interestURL = APIConstants.baseURL + "/main/interest"
    static let detailBookStoreURL = APIConstants.baseURL + "/main/detail/"
    static let mapURL = APIConstants.baseURL + "/main/map/"
    static let reviewURL = APIConstants.baseURL + "/main/detail/review2/" //13.209.107.188:3000/main/detail/review2/20
    static let searchURL = APIConstants.baseURL + "/main/search/" 
    
    static let mypageURL = APIConstants.baseURL + "/main/mypage"
    static let profileURL = APIConstants.baseURL + "/user/profile"
    static let recentURL = APIConstants.baseURL + "/main/recent"
}
