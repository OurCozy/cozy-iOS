//
//  MyPageViewController.swift
//  Cozy
//
//  Created by IJ . on 2020/07/03.
//  Copyright © 2020 jun. All rights reserved.
//

import UIKit

class MyPageViewController: UIViewController {

    
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var lastBookLabel: UILabel!
    
    @IBOutlet weak var profileView: UIView!
    @IBOutlet var profileTapRecognizer: UITapGestureRecognizer!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(MyPage.goPage(_:)))
//        self.profileView.addGestureRecognizer(tapGesture)
    }
    
//    func goPage(sender:UIGestureRecognizer)
//    {
//        let storyboard = UIStoryboard(name: MyPage, bundle: nil)
//
//        let viewController = storyboard.instantiateViewControllerWithIdentifier("이동할 뷰")
//
//                self.navigationController!.pushViewController(viewController, animated: true)
//    }


}
