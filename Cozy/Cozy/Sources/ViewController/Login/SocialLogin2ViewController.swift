//
//  SocialLogin2ViewController.swift
//  Cozy
//
//  Created by 최은지 on 2020/07/14.
//  Copyright © 2020 jun. All rights reserved.
//

import UIKit

class SocialLogin2ViewController: UIViewController {
    
    @IBOutlet weak var otherKakakoLoginView: UIView!
    @IBOutlet weak var easyLoginView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.otherKakakoLoginView.layer.cornerRadius = 5
        self.easyLoginView.layer.cornerRadius = 5
        
    }
    
    
    @IBAction func clickCloseButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
