//
//  SignUpViewController.swift
//  Cozy
//
//  Created by 양지영 on 2020/07/17.
//  Copyright © 2020 jun. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    
    let border1 = CALayer()
    let border2 = CALayer()
    let border3 = CALayer()
    let border4 = CALayer()
    
    @IBOutlet weak var nicknameTextfield: UITextField!
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var checkpwdTextfield: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nicknameTextfield.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
    setTextFieldStyle()
        
    }
    
    @IBAction func dismissView(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
//        self.dismiss(animated: true, completion: nil)
    }
    
    func setTextFieldStyle(){
        nicknameTextfield.borderStyle = .none
        
        border1.frame = CGRect(x: 0, y: nicknameTextfield.frame.size.height-1, width: nicknameTextfield.frame.width, height: 1)
        border1.backgroundColor = UIColor.veryLightPinkTwo.cgColor
        nicknameTextfield.layer.addSublayer((border1))
        nicknameTextfield.textAlignment = .left
        nicknameTextfield.textColor = UIColor.black
        
        emailTextfield.borderStyle = .none
        
        border2.frame = CGRect(x: 0, y: emailTextfield.frame.size.height-1, width: emailTextfield.frame.width, height: 1)
        border2.backgroundColor = UIColor.veryLightPinkTwo.cgColor
        emailTextfield.layer.addSublayer((border2))
        emailTextfield.textAlignment = .left
        emailTextfield.textColor = UIColor.black
        
        passwordTextfield.borderStyle = .none
        
        border3.frame = CGRect(x: 0, y: passwordTextfield.frame.size.height-1, width: passwordTextfield.frame.width, height: 1)
        border3.backgroundColor = UIColor.veryLightPinkTwo.cgColor
        passwordTextfield.layer.addSublayer((border3))
        passwordTextfield.textAlignment = .left
        passwordTextfield.textColor = UIColor.black
        
        checkpwdTextfield.borderStyle = .none
        
        border4.frame = CGRect(x: 0, y: checkpwdTextfield.frame.size.height-1, width: checkpwdTextfield.frame.width, height: 1)
        border4.backgroundColor = UIColor.veryLightPinkTwo.cgColor
        checkpwdTextfield.layer.addSublayer((border4))
        checkpwdTextfield.textAlignment = .left
        checkpwdTextfield.textColor = UIColor.black
    }

}

extension SignUpViewController : UITextFieldDelegate{
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        if textField.text?.isEmpty == true {
//            self.loginButton.setTitleColor(UIColor.veryLightPinkTwo, for: .normal)
//            self.autoLoginLabel.textColor = UIColor.veryLightPinkTwo
//            self.autoLoginButton.layer.borderColor = UIColor.veryLightPinkTwo.cgColor
//        } else {
//            self.loginButton.setTitleColor(UIColor.dustyOrange, for: .normal)
//            self.autoLoginLabel.textColor = UIColor.dustyOrange
//            self.autoLoginButton.layer.borderColor = UIColor.dustyOrange.cgColor
//        }
//    }
//    
//    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        view.endEditing(true)
//    }
//    
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        return true
//    }
    
}
