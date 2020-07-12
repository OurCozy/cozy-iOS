//
//  LoginViewController.swift
//  Cozy
//
//  Created by 최은지 on 2020/07/13.
//  Copyright © 2020 jun. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailLoginButton: UIButton!
    @IBOutlet weak var signinButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.emailLoginButton.settagButton()
        self.signinButton.settagButton()
    }
    
    @IBAction func goEmailLogin(_ sender: UIButton) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        vc.modalPresentationStyle = .overCurrentContext
        
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func goSignin(_ sender: UIButton) {
    }
    
}
