//
//  CountTableViewCell.swift
//  Cozy
//
//  Created by 최은지 on 2020/07/05.
//  Copyright © 2020 jun. All rights reserved.
//

import UIKit

class CountTableViewCell: UITableViewCell {

    @IBOutlet weak var countLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
