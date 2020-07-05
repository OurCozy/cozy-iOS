//
//  UserNameTableViewCell.swift
//  Cozy
//
//  Created by 양재욱 on 2020/07/05.
//  Copyright © 2020 jun. All rights reserved.
//

import UIKit

class UserNameTableViewCell: UITableViewCell {
    
    @IBOutlet weak var userName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
