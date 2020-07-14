//
//  LastBookstoreCell.swift
//  Cozy
//
//  Created by 양지영 on 2020/07/11.
//  Copyright © 2020 jun. All rights reserved.
//

import UIKit

class LastBookstoreCell: UICollectionViewCell {
    static let identifier: String = "LastBookstoreCell"
    
    
    @IBOutlet weak var bookstoreImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    func set(_ bookstoreInformation: LastBookstore){
        bookstoreImageView.image = bookstoreInformation.bookstoreImage
//        bookstoreImageView.layer.cornerRadius = 5
        nameLabel.text = bookstoreInformation.bookstoreName
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        bookstoreImageView.layer.cornerRadius = 5
        
    }
    
//    func cellSettings(){
//        bookstoreImageView.layer.cornerRadius = 5
//        
//    }
}
