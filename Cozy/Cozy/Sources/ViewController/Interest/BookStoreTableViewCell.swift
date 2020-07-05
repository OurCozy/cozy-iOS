//
//  BookStoreTableViewCell.swift
//  Cozy
//
//  Created by 양재욱 on 2020/07/05.
//  Copyright © 2020 jun. All rights reserved.
//

import UIKit

class BookStoreTableViewCell: UITableViewCell {

    @IBOutlet weak var wholeView: UIView!
    
    @IBOutlet weak var bookStoreImage: UIImageView!
    @IBOutlet weak var bookStoreName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
