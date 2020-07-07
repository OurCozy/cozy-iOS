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


//으어어 View의 CommonView 클래스 설정 해제해주고
//topConstraint 옆 Relation클릭해서 toplabel+16pt 설정해주니작동됨
