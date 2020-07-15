//
//  EmailLoginViewController.swift
//  Cozy
//
//  Created by 양재욱 on 2020/07/15.
//  Copyright © 2020 jun. All rights reserved.
//

import UIKit

class EmailLoginViewController: UIViewController {
    
    let border1 = CALayer()
    let border2 = CALayer()
    
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var pwTextField: UITextField!
    @IBOutlet weak var autoLoginButton: UIButton!
    @IBOutlet weak var autoLoginLabel: UILabel!
    @IBOutlet weak var checkIdButton: UIButton!
    @IBOutlet weak var checkPwButton: UIButton!
    @IBOutlet weak var simpleLine: UIView!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        idTextField.delegate = self
        pwTextField.delegate = self
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        setTextFieldStyle()
        autoLoginButton.layer.cornerRadius = 9
        autoLoginButton.layer.borderWidth = 1
        autoLoginButton.layer.borderColor = UIColor.veryLightPinkTwo.cgColor
        autoLoginLabel.textColor = UIColor.veryLightPinkTwo
        checkIdButton.tintColor = UIColor.brownishGrey
        checkPwButton.tintColor = UIColor.brownishGrey
        simpleLine.backgroundColor = UIColor.brownGrey
    }
    
    func setTextFieldStyle(){
        idTextField.borderStyle = .none
        
        border1.frame = CGRect(x: 0, y: idTextField.frame.size.height-1, width: idTextField.frame.width, height: 1)
        border1.backgroundColor = UIColor.veryLightPinkTwo.cgColor
        idTextField.layer.addSublayer((border1))
        idTextField.textAlignment = .left
        idTextField.textColor = UIColor.black
        
        pwTextField.borderStyle = .none
        
        border2.frame = CGRect(x: 0, y: pwTextField.frame.size.height-1, width: pwTextField.frame.width, height: 1)
        border2.backgroundColor = UIColor.veryLightPinkTwo.cgColor
        pwTextField.layer.addSublayer((border2))
        pwTextField.textAlignment = .left
        pwTextField.textColor = UIColor.black
    }
    
    @IBAction func loginAction(_ sender: Any) {
        guard let inputEmail = idTextField.text else { return }
        guard let inputPWD = pwTextField.text else { return }
        
        LoginService.loginShared.login(id: inputEmail, pwd: inputPWD) { networkResult in
            switch networkResult {
                
            case .success(let token):
                guard let token = token as? String else { return }
                UserDefaults.standard.set(token, forKey: "token")
                let sb = UIStoryboard(name: "Main", bundle: nil)
                let vc = sb.instantiateViewController(withIdentifier: "ViewController") as! ViewController
                self.navigationController?.pushViewController(vc, animated: true)
            
            case .requestErr(let message):
                guard let message = message as? String else { return }
                let alertViewController = UIAlertController(title: "로그인 실패", message: message, preferredStyle: .alert)
                let action = UIAlertAction(title: "확인", style: .cancel, handler: nil)
                alertViewController.addAction(action)
                self.present(alertViewController, animated: true, completion: nil)
                
            case .pathErr: print("path")
            case .serverErr: print("serverErr")
            case .networkFail: print("networkFail") }
        }
    }
    
    
}

extension EmailLoginViewController: UITextFieldDelegate{
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
}
