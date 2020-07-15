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
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
