//
//  reviewTableViewCell.swift
//  Cozy
//
//  Created by IJ . on 2020/07/13.
//  Copyright © 2020 jun. All rights reserved.
//

import UIKit

class reviewTableViewCell: UITableViewCell {

    @IBOutlet weak var reviewLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        reviewLabel.text = "asdf"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
