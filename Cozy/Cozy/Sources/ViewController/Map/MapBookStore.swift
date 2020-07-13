//
//  MapBookStore.swift
//  Cozy
//
//  Created by 최은지 on 2020/07/13.
//  Copyright © 2020 jun. All rights reserved.
//

import Foundation
import UIKit

struct MapBook {
    var bookStoreImageName: String
    var bookStoreName: String
    var hashTag1: String
    var hashTag2: String
    var hashTag3: String
    var isSelected: Bool
    
    init(bookStoreImageName: String, bookStoreName: String, hashTag1: String, hashTag2: String, hashTag3: String, isSelected: Bool) {
        self.bookStoreImageName = bookStoreImageName
        self.bookStoreName = bookStoreName
        self.hashTag1 = hashTag1
        self.hashTag2 = hashTag2
        self.hashTag3 = hashTag3
        self.isSelected = isSelected
    }
}
