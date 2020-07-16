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
    
    @IBOutlet weak var searchWholeView: UIView!
    @IBOutlet weak var searchTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.searchWholeView.setTagView()
        
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer()
        tapGesture.delegate = self
        
        self.view.addGestureRecognizer(tapGesture)
        
        self.settingButtonLayer()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    @IBAction func clickKeywords(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Search", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SearchListViewController") as! SearchListViewController
        
        vc.searchRegion = sender.titleLabel?.text ?? ""
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func goSearchList(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Search", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SearchListViewController") as! SearchListViewController
        
        vc.searchRegion = self.searchTextField.text ?? ""
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func clickCloseButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
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
    }
    
}
