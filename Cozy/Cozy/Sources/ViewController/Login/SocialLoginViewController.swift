//
//  SocialLoginViewController.swift
//  Cozy
//
//  Created by 최은지 on 2020/07/13.
//  Copyright © 2020 jun. All rights reserved.
//

import UIKit

class SocialLoginViewController: UIViewController, UIGestureRecognizerDelegate {
    
    var isFacebook: Bool = false
    
    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var socialImage: UIImageView!
    @IBOutlet weak var socialLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.alertView.layer.cornerRadius = 5
        
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer()
        tapGesture.delegate = self
        
        self.view.addGestureRecognizer(tapGesture)
        
        if isFacebook {
            self.socialLabel.numberOfLines = 0
            
            let style = NSMutableParagraphStyle()
            style.lineSpacing = 3.0
            style.alignment = .center
            
            let socialText = NSAttributedString(string: "'Cozy'이(가) \n 'facebook'을(를) 사용하여 \n 로그인하려고 합니다. ", attributes: [.font : UIFont.systemFont(ofSize: 14) ])
            let attrString = NSMutableAttributedString()
            attrString.append(socialText)
            attrString.addAttributes([.paragraphStyle : style], range: NSMakeRange(0, attrString.length))
            
            self.socialLabel.attributedText = attrString
            self.socialImage.image = UIImage(named: "btnFacebookLogin")
        } else {
            self.socialLabel.numberOfLines = 0
            
            let style = NSMutableParagraphStyle()
            style.lineSpacing = 3.0
            style.alignment = .center
            
            let socialText = NSAttributedString(string: "'Cozy'이(가) \n 'naver'을(를) 사용하여 \n 로그인하려고 합니다. ", attributes: [.font : UIFont.systemFont(ofSize: 14) ])
            let attrString = NSMutableAttributedString()
            attrString.append(socialText)
            attrString.addAttributes([.paragraphStyle : style], range: NSMakeRange(0, attrString.length))
            self.socialLabel.attributedText = attrString
            self.socialImage.image = UIImage(named: "btnNaverLogin")
        }
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        self.dismiss(animated: true, completion: nil)
        return true
    }
    
    @IBAction func clickCloseButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
