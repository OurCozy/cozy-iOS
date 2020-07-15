//
//  UIImageViewKingfisher+Extension.swift
//  Cozy
//
//  Created by IJ . on 2020/07/14.
//  Copyright © 2020 jun. All rights reserved.
//

import Foundation
import Kingfisher

extension UIImageView{

    func setImage(from url: String) {
            self.kf.indicatorType = .activity
            let cache = ImageCache.default
            
            cache.retrieveImage(forKey: url) { result in
                switch result {
                case .success(let value):
                    if value.image != nil { self.image = value.image }
                    else { self.kf.setImage(with: URL(string: url)) }
                case .failure(let err):
                    print(err.errorCode)
                }
                
            }
        }
}
