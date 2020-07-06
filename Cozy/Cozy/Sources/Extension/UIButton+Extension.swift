//
//  UIButton+Extension.swift
//  Cozy
//
//  Created by 최은지 on 2020/07/06.
//  Copyright © 2020 jun. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    
    func settagButton(){
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.dustyOrange.cgColor
        self.layer.cornerRadius = 5
    }
}
