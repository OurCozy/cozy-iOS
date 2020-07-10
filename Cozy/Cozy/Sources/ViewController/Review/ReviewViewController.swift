//
//  ReviewViewController.swift
//  Cozy
//
//  Created by 최은지 on 2020/07/10.
//  Copyright © 2020 jun. All rights reserved.
//

import UIKit

class ReviewViewController: UIViewController {

    @IBOutlet weak var star1: UIButton!
    @IBOutlet weak var star2: UIButton!
    @IBOutlet weak var star3: UIButton!
    @IBOutlet weak var star4: UIButton!
    @IBOutlet weak var star5: UIButton!
    
    
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.star1.tag = 1
        self.star2.tag = 2
        self.star3.tag = 3
        self.star4.tag = 4
        self.star5.tag = 5
        
        self.nextButton.isEnabled = false
    }
    
    @IBAction func goBack(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func goNextButton(_ sender: UIButton) {
    }
    
    @IBAction func clickStar(_ sender: UIButton) {
        self.nextButton.isEnabled = true
        self.nextButton.setTitleColor(UIColor.dustyOrange, for: .normal)
        
//        for i in 0...sender.tag {
//            
//        }
        
        switch sender.tag {
        case 1:
            self.star1.setImage(UIImage(named: "icCommentsStarSelected"), for: .normal)
            self.star2.setImage(UIImage(named: "icCommentsStar"), for: .normal)
            self.star3.setImage(UIImage(named: "icCommentsStar"), for: .normal)
            self.star4.setImage(UIImage(named: "icCommentsStar"), for: .normal)
            self.star5.setImage(UIImage(named: "icCommentsStar"), for: .normal)
        case 2:
            self.star1.setImage(UIImage(named: "icCommentsStarSelected"), for: .normal)
            self.star2.setImage(UIImage(named: "icCommentsStarSelected"), for: .normal)
            self.star3.setImage(UIImage(named: "icCommentsStar"), for: .normal)
            self.star4.setImage(UIImage(named: "icCommentsStar"), for: .normal)
            self.star5.setImage(UIImage(named: "icCommentsStar"), for: .normal)
        case 3:
            self.star1.setImage(UIImage(named: "icCommentsStarSelected"), for: .normal)
            self.star2.setImage(UIImage(named: "icCommentsStarSelected"), for: .normal)
            self.star3.setImage(UIImage(named: "icCommentsStarSelected"), for: .normal)
            self.star4.setImage(UIImage(named: "icCommentsStar"), for: .normal)
            self.star5.setImage(UIImage(named: "icCommentsStar"), for: .normal)
        case 4:
            self.star1.setImage(UIImage(named: "icCommentsStarSelected"), for: .normal)
            self.star2.setImage(UIImage(named: "icCommentsStarSelected"), for: .normal)
            self.star3.setImage(UIImage(named: "icCommentsStarSelected"), for: .normal)
            self.star4.setImage(UIImage(named: "icCommentsStarSelected"), for: .normal)
            self.star5.setImage(UIImage(named: "icCommentsStar"), for: .normal)
        case 5 :
            self.star1.setImage(UIImage(named: "icCommentsStarSelected"), for: .normal)
            self.star2.setImage(UIImage(named: "icCommentsStarSelected"), for: .normal)
            self.star3.setImage(UIImage(named: "icCommentsStarSelected"), for: .normal)
            self.star4.setImage(UIImage(named: "icCommentsStarSelected"), for: .normal)
            self.star5.setImage(UIImage(named: "icCommentsStarSelected"), for: .normal)
        default:
            return
        }
        
    }
    
    

}
