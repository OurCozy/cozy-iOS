//
//  CardCollectionViewCell.swift
//  Cozy
//
//  Created by IJ . on 2020/07/06.
//  Copyright © 2020 jun. All rights reserved.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell, NibReusable {
    
    
    @IBOutlet weak var commonView: CommonView!
    
    override func awakeFromNib() {
    super.awakeFromNib()
        
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
        
    // Round the corners
    self.commonView.layer.cornerRadius = 10
    self.commonView.layer.masksToBounds = true
    }
    
}
