//
//  NetworkResult.swift
//  Cozy
//
//  Created by 양재욱 on 2020/07/09.
//  Copyright © 2020 jun. All rights reserved.
//

import Foundation

enum NetworkResult<T> {
    case success(T)
    case requestErr(T)
    case pathErr
    case serverErr
    case networkFail
}
