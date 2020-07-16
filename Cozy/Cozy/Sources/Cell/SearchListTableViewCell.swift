//
//  SearchListTableViewCell.swift
//  Cozy
//
//  Created by 최은지 on 2020/07/17.
//  Copyright © 2020 jun. All rights reserved.
//

import UIKit

class SearchListTableViewCell: UITableViewCell {

    @IBOutlet weak var wholeView: UIView!
    @IBOutlet weak var bookstoreLabel: UILabel!
    @IBOutlet weak var bookstoreImageView: UIImageView!
    
    @IBOutlet weak var hashtag1: UILabel!
    @IBOutlet weak var hashtag2: UILabel!
    @IBOutlet weak var hashtag3: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
