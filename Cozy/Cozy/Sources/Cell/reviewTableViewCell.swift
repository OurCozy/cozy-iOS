//
//  reviewTableViewCell.swift
//  Cozy
//
//  Created by IJ . on 2020/07/13.
//  Copyright © 2020 jun. All rights reserved.
//

import UIKit
import Cosmos
class reviewTableViewCell: UITableViewCell {

    @IBOutlet weak var reviewNameLabel: UILabel!
    @IBOutlet weak var reviewStar: CosmosView!
    @IBOutlet weak var reviewTime: UILabel!
    @IBOutlet weak var reviewWriteLabel: UILabel!
    @IBOutlet weak var reviewImageView: UIImageView!
    @IBOutlet weak var reviewMoreButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
