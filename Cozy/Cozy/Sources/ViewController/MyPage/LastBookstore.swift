//
//  LastBookstore.swift
//  Cozy
//
//  Created by 양지영 on 2020/07/11.
//  Copyright © 2020 jun. All rights reserved.
//
import UIKit
import Foundation

struct LastBookstore{
    var bookstoreImage: UIImage?
    var bookstoreName: String
    
    init(bookstoreImage: String, bookstoreName: String){
        self.bookstoreImage = UIImage(named: bookstoreImage)
        self.bookstoreName = bookstoreName
    }
}
