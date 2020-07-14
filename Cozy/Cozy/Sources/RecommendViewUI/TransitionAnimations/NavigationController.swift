//
//  NavigationController.swift
//  Cozy
//
//  Created by IJ . on 2020/07/07.
//  Copyright © 2020 jun. All rights reserved.
//

import Foundation
import UIKit

class NavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
        self.tabBarItem.image = UIImage(named: "icTabMain")?.withRenderingMode(.alwaysOriginal)
        
        
        
        self.tabBarItem.selectedImage = UIImage(named: "icTabMainSelected")?.withRenderingMode(.alwaysOriginal)
        self.tabBarItem.imageInsets = UIEdgeInsets(top: 12, left: 0, bottom: 0, right: 0)
        
        //Animation Custom때문에 tabbaritem 적용이 NavigationController에서 텝바 이미지 적용
        self.delegate = self
    }
    

}

extension NavigationController: UINavigationControllerDelegate {
    func navigationController(
        _ navigationController: UINavigationController,
        animationControllerFor operation: UINavigationController.Operation,
        from fromVC: UIViewController,
        to toVC: UIViewController
    ) -> UIViewControllerAnimatedTransitioning? {
        return CustomTransitionAnimation(operation: operation, positioningDuration: 1, resizingDuration: 0.5)
    }
}


extension UINavigationController {
    
//    open override var childForStatusBarHidden: UIViewController? {
//        return viewControllers.last
//    }
//
//    open override var childForStatusBarStyle: UIViewController? {
//        return viewControllers.last
//    }
    
//    open override var childForStatusBarHidden: UIViewController?{
//        return self.topViewController
//    }
    
   
}
