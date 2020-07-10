//
//  RecommendViewController.swift
//  Cozy
//
//  Created by IJ . on 2020/07/03.
//  Copyright © 2020 jun. All rights reserved.
//

import UIKit

class RecommendViewController: UIViewController {
    
    @IBOutlet weak var recommendCollectionView: UICollectionView!
    
    
    fileprivate var selectedCell: UICollectionViewCell?
    private var isStatusBarHidden = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //        flowLayout을 이용한 cellsize
        //        let layout = recommendCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        //        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        
        //dev pull 완료
        
//        self.tabBarItem.image = UIImage(named: "icTabMain")?.withRenderingMode(.alwaysOriginal)
//        self.tabBarItem.title = "asdf"
    
        
        
        recommendCollectionView.delegate = self
        recommendCollectionView.dataSource = self
        
        // Set the cells sizes and layout direction
        let layout = UICollectionViewFlowLayout()
        //layout.itemSize = CGSize(width: 327, height: 405)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 36
        layout.sectionInset = UIEdgeInsets(top: 13, left: 13, bottom: 13, right: 13)
        self.recommendCollectionView.collectionViewLayout = layout
        
        self.recommendCollectionView.register(cellType: CardCollectionViewCell.self)
        
    }
    
    
    override var prefersStatusBarHidden: Bool {
        return isStatusBarHidden
    }
    
}


extension RecommendViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if 0 == section {
            return 1
        } else {
            return 8
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0{
            let guideCell = collectionView.dequeueReusableCell(withReuseIdentifier: "logoSearchCell", for: indexPath)
            
            
            return guideCell
        } else {
            let cardCell = collectionView.dequeueReusableCell(for: indexPath, cellType: CardCollectionViewCell.self)
            
            return cardCell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            self.selectedCell = self.recommendCollectionView.cellForItem(at: indexPath)
            
            let vc = DetailViewController.instantiate()
            
            //self.tabBarController?.tabBar.isHidden = true
            self.setTabBarHidden(true)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}


extension RecommendViewController: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let guideSize: CGSize = CGSize.init(width: 327, height: 190)
        //minimumLineSpacing = 36 이므로 디자이너가 요구한 55pt를 맞추기 위해 19pt 사이즈를 height값을 더주었음
        let bounds = UIScreen.main.bounds
        let deviceHeight = bounds.size.height
        
        let recommendCellHeightSize:CGFloat
        
        switch deviceHeight {
        case 667.0: //iphone 6, 6s, 7, 8 => 4.7 inch
            recommendCellHeightSize = 310
        case 812.0: //iphone X, XS => 5.8 inch
            recommendCellHeightSize = 405
        default:
            recommendCellHeightSize = 405
        }
        
        
        let recommendSize: CGSize = CGSize.init(width: 327, height: recommendCellHeightSize)
        
        
        
        
        
        switch indexPath.section {
        case 0:
            return guideSize
        case 1:
            return recommendSize
        default:
            return CGSize.init(width: 0, height: 0)
        }
    }
}

extension RecommendViewController: Animatable {
    var containerView: UIView? {
        return self.recommendCollectionView
    }
    
    var childView: UIView? {
        return self.selectedCell
    }
}

