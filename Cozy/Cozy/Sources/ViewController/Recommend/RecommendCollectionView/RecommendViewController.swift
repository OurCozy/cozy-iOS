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
    
    
    //    private var hiddenCells: [CustomExpandableCollectionViewCell] = []
    //    private var expandedCell: CustomExpandableCollectionViewCell?
    
    fileprivate var selectedCell: UICollectionViewCell?
    private var isStatusBarHidden = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //        flowLayout을 이용한 cellsize
        //        let layout = recommendCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        //        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        
        
        
        recommendCollectionView.delegate = self
        recommendCollectionView.dataSource = self
        
        // Set the cells sizes and layout direction
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 327, height: 405)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 30
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        self.recommendCollectionView.collectionViewLayout = layout
        
        self.recommendCollectionView.register(cellType: CardCollectionViewCell.self)
        
        
    }
    
    
    override var prefersStatusBarHidden: Bool {
        return isStatusBarHidden
    }
    
    
    
    
}


extension RecommendViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        //        guard let cell = recommendCollectionView.dequeueReusableCell(withReuseIdentifier: "sbCustomExpandableCell", for: indexPath) as? CustomExpandableCollectionViewCell else{
        //            return UICollectionViewCell()
        //        }
        
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: CardCollectionViewCell.self)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedCell = self.recommendCollectionView.cellForItem(at: indexPath)
        
        let vc = DetailViewController.instantiate()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    //    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    //        if collectionView.contentOffset.y < 0 ||
    //            collectionView.contentOffset.y > collectionView.contentSize.height - collectionView.frame.height {
    //            return
    //        }
    //
    //
    //        let dampingRatio: CGFloat = 0.8
    //        let initialVelocity: CGVector = CGVector.zero
    //        let springParameters: UISpringTimingParameters = UISpringTimingParameters(dampingRatio: dampingRatio, initialVelocity: initialVelocity)
    //        let animator = UIViewPropertyAnimator(duration: 0.5, timingParameters: springParameters)
    //
    //
    //        self.view.isUserInteractionEnabled = false
    //
    //        if let selectedCell = expandedCell {
    //            isStatusBarHidden = false
    //            //setNeedsStatusBarAppearanceUpdate()
    //
    //            animator.addAnimations {
    //                selectedCell.collapse()
    //
    //                for cell in self.hiddenCells {
    //                    cell.show()
    //                }
    //            }
    //
    //            animator.addCompletion { _ in
    //                collectionView.isScrollEnabled = true
    //
    //                self.expandedCell = nil
    //                self.hiddenCells.removeAll()
    //            }
    //        } else {
    //            isStatusBarHidden = true
    //
    //            collectionView.isScrollEnabled = false
    //
    //            let selectedCell = collectionView.cellForItem(at: indexPath)! as! CustomExpandableCollectionViewCell
    //            let frameOfSelectedCell = selectedCell.frame
    //
    //            expandedCell = selectedCell
    //            hiddenCells = collectionView.visibleCells.map { $0 as! CustomExpandableCollectionViewCell }.filter { $0 != selectedCell }
    //
    //            animator.addAnimations {
    //                selectedCell.expand(in: collectionView)
    //
    //                for cell in self.hiddenCells {
    //                    cell.hide(in: collectionView, frameOfSelectedCell: frameOfSelectedCell)
    //                }
    //            }
    //        }
    //
    //
    //        animator.addAnimations {
    //            self.setNeedsStatusBarAppearanceUpdate()
    //        }
    //
    //        animator.addCompletion { _ in
    //            self.view.isUserInteractionEnabled = true
    //        }
    //
    //        animator.startAnimation()
    //    }
    
    
}


extension RecommendViewController: UIScrollViewDelegate {
    
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        
        
        
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

//extension RecommendViewController: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//        let cellWidth = CGFloat(327)
//        let cellHeight = CGFloat(405)
//
//        return CGSize(width: cellWidth, height: cellHeight)
//    }
//}
