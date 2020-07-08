//
//  LogoSearchCollectionViewCell.swift
//  Cozy
//
//  Created by IJ . on 2020/07/07.
//  Copyright © 2020 jun. All rights reserved.
//

import UIKit

class LogoSearchCollectionViewCell: UICollectionViewCell, Reusable {
    
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var guideLabel1: UILabel!
    @IBOutlet weak var guideLabel2: UILabel!
    private var myCellIdentifier:String = "logoSearchCell"
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func touchUpSearchButton(_ sender: UIButton) {
        print("MainSearchButton 터치됨")
    }
    
}
