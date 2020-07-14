//
//  ReviewViewController.swift
//  Cozy
//
//  Created by 최은지 on 2020/07/10.
//  Copyright © 2020 jun. All rights reserved.
//

import UIKit
import Cosmos

class ReviewViewController: UIViewController, UIGestureRecognizerDelegate, UITextViewDelegate {

    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var reviewTextView: UITextView!
    
    @IBOutlet weak var ratingView: CosmosView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer()
        tapGesture.delegate = self
        
        self.view.addGestureRecognizer(tapGesture)
        
        self.reviewTextView.text = "내용을 입력하세요"
        self.reviewTextView.textColor = UIColor.veryLightPinkTwo
        
        self.reviewTextView.delegate = self
        
        self.ratingView.didFinishTouchingCosmos = { rating in
            print("🌟 rating? ", rating)
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.veryLightPinkTwo {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "내용을 입력하세요"
            textView.textColor = UIColor.veryLightPinkTwo
            
            self.nextButton.setTitleColor(UIColor.veryLightPinkTwo, for: .normal)
        } else {
            self.nextButton.setTitleColor(UIColor.dustyOrange, for: .normal)
        }
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    @IBAction func goBack(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func goNextButton(_ sender: UIButton) {
        
    }

}
