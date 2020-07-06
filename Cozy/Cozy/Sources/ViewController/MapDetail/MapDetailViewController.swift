//
//  MapDetailViewController.swift
//  Cozy
//
//  Created by 최은지 on 2020/07/05.
//  Copyright © 2020 jun. All rights reserved.
//

import UIKit

class MapDetailViewController: UIViewController {

    @IBOutlet weak var bookstoreImageView: UIImageView!
    
    @IBOutlet weak var tagButton1: UIButton!
    @IBOutlet weak var tagButton2: UIButton!
    @IBOutlet weak var tagButton3: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setTagButtonUI()
    }
    
    @IBAction func clickBackButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func setTagButtonUI(){
        self.tagButton1.settagButton()
        self.tagButton2.settagButton()
        self.tagButton3.settagButton()
    }
    
    @IBAction func clickBookMarkButton(_ sender: UIButton) {
        sender.setImage(UIImage(named: "icBookmarkSelected"), for: .normal)
    }
}
