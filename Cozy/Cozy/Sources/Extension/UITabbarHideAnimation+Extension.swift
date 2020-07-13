//
//  UITabbarHideAnimation+Extension.swift
//  Cozy
//
//  Created by IJ . on 2020/07/08.
//  Copyright © 2020 jun. All rights reserved.
//

import UIKit

extension UIViewController{
    //    func setTabBarHidden(_ hidden: Bool, animated: Bool = true, duration: TimeInterval = 0.5) {
    //        if self.tabBarController?.tabBar.isHidden != hidden{
    //            if animated {
    //                //Show the tabbar before the animation in case it has to appear
    //                if (self.tabBarController?.tabBar.isHidden)!{
    //                    self.tabBarController?.tabBar.isHidden = hidden
    //                }
    //                if let frame = self.tabBarController?.tabBar.frame {
    //                    let factor: CGFloat = hidden ? 1 : -1
    //                    let y = frame.origin.y + (frame.size.height * factor)
    //                    UIView.animate(withDuration: duration, animations: {
    //                        self.tabBarController?.tabBar.frame = CGRect(x: frame.origin.x, y: y, width: frame.width, height: frame.height)
    //                    }) { (bool) in
    //                        //hide the tabbar after the animation in case ti has to be hidden
    //                        //hidden하고나서 다시 false할때 isHidden값이 nil이됨...why?
    //                        if (!(self.tabBarController?.tabBar.isHidden)!){
    //                            self.tabBarController?.tabBar.isHidden = hidden
    //                        }
    //                    }
    //                }
    //            }
    //        }
    //    }
        
        
        func setTabBarHidden(_ hidden: Bool, animated: Bool = true, duration: TimeInterval = 0.4) {
            if animated {
                print("setTabBarHidden호출")
                if let frame = self.tabBarController?.tabBar.frame {
                    let factor: CGFloat = hidden ? 1 : -1
                    let y = frame.origin.y + (frame.size.height * factor)
                    UIView.animate(withDuration: duration, animations: {
                        self.tabBarController?.tabBar.frame = CGRect(x: frame.origin.x, y: y, width: frame.width, height: frame.height)
                    })
                    return
                }
            }
            self.tabBarController?.tabBar.isHidden = hidden
        }
}
