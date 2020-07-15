//
//  EmailLoginViewController.swift
//  Cozy
//
//  Created by 양재욱 on 2020/07/15.
//  Copyright © 2020 jun. All rights reserved.
//

import UIKit

class EmailLoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var pwTextField: UITextField!
    @IBOutlet weak var autoLoginButton: UIButton!
    @IBOutlet weak var autoLoginLabel: UILabel!
    @IBOutlet weak var seperateLine: UIView!
    @IBOutlet weak var checkIdLabel: UILabel!
    @IBOutlet weak var checkPwLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    
    override func viewDidLayoutSubviews() {
        setTextFieldStyle()
        setButtonStyle()
        setLabelStyle()
    }


    func setTextFieldStyle(){
        emailTextField.borderStyle = .none
        let border1 = CALayer()
        border1.frame = CGRect(x: 0, y: emailTextField.frame.size.height-1, width: emailTextField.frame.width, height: 1)
        border1.backgroundColor = UIColor.veryLightPinkTwo.cgColor
        emailTextField.layer.addSublayer((border1))
        emailTextField.textAlignment = .left
        emailTextField.textColor = UIColor.black
        
        pwTextField.borderStyle = .none
        let border2 = CALayer()
        border2.frame = CGRect(x: 0, y: pwTextField.frame.size.height-1, width: pwTextField.frame.width, height: 1)
        border2.backgroundColor = UIColor.veryLightPinkTwo.cgColor
        pwTextField.layer.addSublayer((border2))
        pwTextField.textAlignment = .left
        pwTextField.textColor = UIColor.black
    }
    
    func setButtonStyle(){
        autoLoginButton.layer.borderWidth = 1
        autoLoginButton.layer.borderColor = UIColor.veryLightPinkTwo.cgColor
        autoLoginButton.layer.cornerRadius = 9
    }
    
    func setLabelStyle(){
        autoLoginLabel.textColor = UIColor.veryLightPinkTwo
        checkIdLabel.textColor = UIColor.brownishGrey
        checkPwLabel.textColor = UIColor.brownishGrey
        seperateLine.backgroundColor = UIColor.brownGrey
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
