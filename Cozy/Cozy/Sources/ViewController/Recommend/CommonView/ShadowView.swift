//
//  ShadowView.swift
//  Cozy
//
//  Created by IJ . on 2020/07/06.
//  Copyright © 2020 jun. All rights reserved.
//

import UIKit

class ShadowView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }

    func commonInit() {
        self.layer.shadowRadius = 4
        self.layer.shadowOffset = CGSize(width: 0, height: 8)
        self.layer.shadowOpacity = 0.15
        self.layer.masksToBounds = false
    }
}
