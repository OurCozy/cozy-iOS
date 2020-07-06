//
//  SearchViewController.swift
//  Cozy
//
//  Created by 최은지 on 2020/07/06.
//  Copyright © 2020 jun. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var button5: UIButton!
    @IBOutlet weak var button6: UIButton!
    @IBOutlet weak var button7: UIButton!
    @IBOutlet weak var button8: UIButton!
    
    @IBOutlet weak var searchWholeView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.searchWholeView.setTagView()
        
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer()
        tapGesture.delegate = self
        
        self.view.addGestureRecognizer(tapGesture)
        
        self.settingButtonLayer()
    }
    
    @IBAction func clickCloseButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    func settingButtonLayer(){
        self.button1.settagButton()
        self.button2.settagButton()
        self.button3.settagButton()
        self.button4.settagButton()
        self.button5.settagButton()
        self.button6.settagButton()
        self.button7.settagButton()
        self.button8.settagButton()
    }
}
