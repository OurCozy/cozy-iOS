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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    @IBAction func goEmailLogin(_ sender: UIButton) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func goSignin(_ sender: UIButton) {
        print("click🌟")
        
        let sb = UIStoryboard(name: "MyPage", bundle: nil)
        let vc = sb.instantiateViewController(identifier: "NoticeViewController") as! NoticeViewController
        self.navigationController?.pushViewController(vc, animated: true)
        
//        let sb = UIStoryboard(name: "Signin", bundle: nil)
//        let vc = sb.instantiateViewController(withIdentifier: "SigninViewController") as! SigninViewController
//        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func goKakaoLogin(_ sender: UIButton) {
        let sb = UIStoryboard(name: "SocialLogin", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "SocialLogin2ViewController") as! SocialLogin2ViewController
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func goFacebookLogin(_ sender: UIButton) {
        let sb = UIStoryboard(name: "SocialLogin", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "SocialLoginViewController") as! SocialLoginViewController
        vc.modalPresentationStyle = .overCurrentContext
        vc.isFacebook = true
        self.present(vc, animated: false)
    }
    
    @IBAction func goNaverLogin(_ sender: UIButton) {
        let sb = UIStoryboard(name: "SocialLogin", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "SocialLoginViewController") as! SocialLoginViewController
        vc.modalPresentationStyle = .overCurrentContext
        vc.isFacebook = false
        self.present(vc, animated: false)
    }
    
}
