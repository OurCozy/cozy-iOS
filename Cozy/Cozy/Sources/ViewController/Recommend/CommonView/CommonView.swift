//
//  CommonView.swift
//  Cozy
//
//  Created by IJ . on 2020/07/06.
//  Copyright © 2020 jun. All rights reserved.
//

import UIKit

class CommonView: UIView, NibOwnerLoadable {
    
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    var topConstraintValue: CGFloat {
        get { return self.topConstraint.constant }
        set { self.topConstraint.constant = newValue }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.loadNibContent()
    }
    
}
