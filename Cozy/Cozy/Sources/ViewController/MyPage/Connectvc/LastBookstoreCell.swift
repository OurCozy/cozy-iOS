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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        bookstoreImageView.layer.cornerRadius = 5
        
    }
    
    func setRecentData(bookstoreName:String, image1: String){
        let url = URL(string: image1)
        guard let data = try? Data(contentsOf: url!) else {return}
        self.bookstoreImageView.image = UIImage(data: data)
        self.nameLabel.text = bookstoreName
        
    }
}
