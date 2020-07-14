//
//  LibraryTableViewCell.swift
//  Cozy
//
//  Created by 최은지 on 2020/07/05.
//  Copyright © 2020 jun. All rights reserved.
//

import UIKit

class LibraryTableViewCell: UITableViewCell {

    @IBOutlet weak var wholeView: UIView!
    
    @IBOutlet weak var bookstoreImageView: UIImageView!
    @IBOutlet weak var bookstoreName: UILabel!
    
    @IBOutlet weak var tagView: UIView!
    @IBOutlet weak var tagLabel: UILabel!
    
    @IBOutlet weak var tagView2: UIView!
    @IBOutlet weak var tagLabel2: UILabel!
    
    @IBOutlet weak var tagView3: UIView!
    @IBOutlet weak var tagLabel3: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
