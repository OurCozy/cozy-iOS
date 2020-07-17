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
    
    var RecommendationList: [Recommendation.RecommendationData] = []
    
    private var justOneServerConnect = false
    
    @IBOutlet weak var nicknameLabel: UILabel!
    
    var logoSearchCheck: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //                flowLayout을 이용한 cellsize
        //                let layout = recommendCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        //                layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        //
        //        dev pull 완료
        //
        //        self.tabBarItem.image = UIImage(named: "icTabMain")?.withRenderingMode(.alwaysOriginal)
        //        self.tabBarItem.title = "asdf"
        
        
        // tab bar item image 설정
//        self.tabBarController?.tabBar.items![1].image = UIImage(named: "ictabmap")
//        self.tabBarController?.tabBar.items![2].image = UIImage(named: "tabStoryIc")
//        self.tabBarController?.tabBar.items![3].image = UIImage(named: "tabProfileIc")
        
        // tab bar color 설정
        //self.tabBarController?.tabBar.selectedImageTintColor = UIColor.marigold
        
        
        
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
    
    override func viewWillAppear(_ animated: Bool) {
       // downloadRecommendationData()
        super.viewWillAppear(animated)
       
//        self.tabBarController?.tabBar.isHidden = false
//        UIView.animate(withDuration: 0.3) {
//            self.view.layoutIfNeeded()
//        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if justOneServerConnect == false {
         downloadRecommendationData()
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return isStatusBarHidden
    }
    
    func downloadRecommendationData(){
        RecommendationService.shared.getRecommendationData { NetworkResult in
            switch NetworkResult {
            case .success(let data) :
                print("🎁 recommendation success 🎁 ")
                
                guard let data = data as? [Recommendation.RecommendationData] else {
                    print("데이터에서 리턴")
                    return
                }
                
                self.RecommendationList = data
                self.logoSearchCheck = 1
                DispatchQueue.main.async {
                    self.recommendCollectionView.reloadData()
                }
                print("휘뚜루마뚜루 \(self.RecommendationList[0].location)")
                self.justOneServerConnect = true
                
            case .requestErr(_):
                print("Request error@@")
            case .pathErr:
                print("path error")
            case .serverErr:
                print("server error")
            case .networkFail:
                print("network error")
            }
        }
    }
    
    
    
}


extension RecommendViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if 0 == section {
            return logoSearchCheck
        } else {
            return RecommendationList.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let guideCell = collectionView.dequeueReusableCell(withReuseIdentifier: "logoSearchCell", for: indexPath) as! LogoSearchCollectionViewCell
            guideCell.guideLabel1.text = "\(self.RecommendationList[0].nickname)님,"
            
            return guideCell
        } else {
            let cardCell = collectionView.dequeueReusableCell(for: indexPath, cellType: CardCollectionViewCell.self)
            
            DispatchQueue.global().async {
              
                DispatchQueue.main.async {
                    cardCell.commonView.mainRecommendImageView.setImage(from: self.RecommendationList[indexPath.row].profile)
                }
            }
            
            
            
            cardCell.commonView.guideLabel1.text = self.RecommendationList[indexPath.row].shortIntro
            cardCell.commonView.guideLabel2.text = self.RecommendationList[indexPath.row].shortIntro2
            cardCell.commonView.bookstoreName.text = self.RecommendationList[indexPath.row].bookstoreName
            cardCell.commonView.bookstoreAddress.text = self.RecommendationList[indexPath.row].location
            
            return cardCell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            self.selectedCell = self.recommendCollectionView.cellForItem(at: indexPath)
            
            let vc = DetailViewController.instantiate()
            
//            vc.hidesBottomBarWhenPushed = true
            self.setTabBarHidden(true)
            //setTabBarHidden 아이폰 SE2 , 8 , 8+만 안먹힘, 분기처리 생각중
            
            //self.tabBarController?.tabBar.isHidden = true
            
            vc.getMainRecommendImageString = self.RecommendationList[indexPath.row].profile
            vc.getGuideLabel1 = self.RecommendationList[indexPath.row].shortIntro
            vc.getGuideLabel2 = self.RecommendationList[indexPath.row].shortIntro2
            vc.getNameString = self.RecommendationList[indexPath.row].bookstoreName
            vc.getLocationString = self.RecommendationList[indexPath.row].location
            vc.getNowBookStoreIndex = self.RecommendationList[indexPath.row].bookstoreIdx
            print("해당 북스토어 인덱스값:\(self.RecommendationList[indexPath.row].bookstoreIdx)")
            self.view.setNeedsLayout()
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

