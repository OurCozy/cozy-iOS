//
//  SplashViewController.swift
//  Cozy
//
//  Created by 최은지 on 2020/07/13.
//  Copyright © 2020 jun. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {

    @IBOutlet weak var cozyLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        perform(#selector(goMain), with: nil, afterDelay: 2.0)
    }
    
    // MARK : Main 화면으로 넘어가기
    @objc func goMain(){        
        let sb = UIStoryboard(name: "Login", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        vc.modalPresentationStyle = .overCurrentContext
        
//        self.present(vc, animated: true, completion: nil)
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }

}
