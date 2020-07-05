//
//  UIView+Extension.swift
//  Cozy
//
//  Created by 최은지 on 2020/07/04.
//  Copyright © 2020 jun. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func setViewShadow(){
        self.layer.cornerRadius = 10
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.2
        self.layer.shadowOffset = .zero
        self.layer.shadowRadius = 2
    }
    
    func setTagView(){
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.dustyOrange.cgColor
    }
    
}
