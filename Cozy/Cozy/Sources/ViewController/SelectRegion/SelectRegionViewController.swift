//
//  SelectRegionViewController.swift
//  Cozy
//
//  Created by 최은지 on 2020/07/09.
//  Copyright © 2020 jun. All rights reserved.
//

import UIKit

class SelectRegionViewController: UIViewController {
    
    @IBOutlet weak var regionButton1: UIButton!
    @IBOutlet weak var regionButton2: UIButton!
    @IBOutlet weak var regionButton3: UIButton!
    @IBOutlet weak var regionButton4: UIButton!
    @IBOutlet weak var regionButton5: UIButton!
    @IBOutlet weak var regionButton6: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setRegionButtons()
    }
    
    func setRegionButtons(){
        self.regionButton1.setRegionButton()
        self.regionButton2.setRegionButton()
        self.regionButton3.setRegionButton()
        self.regionButton4.setRegionButton()
        self.regionButton5.setRegionButton()
        self.regionButton6.setRegionButton()
    }
    
}
