//
//  Expandable.swift
//  Cozy
//
//  Created by IJ . on 2020/07/05.
//  Copyright © 2020 jun. All rights reserved.
//

import UIKit

protocol Expandable {
    func collapse()
    func expand(in collectionView: UICollectionView)
}
