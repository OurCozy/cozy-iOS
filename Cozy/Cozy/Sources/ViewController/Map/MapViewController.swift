//
//  MapViewController.swift
//  Cozy
//
//  Created by IJ . on 2020/07/03.
//  Copyright © 2020 jun. All rights reserved.
//

import UIKit
import Kingfisher

class MapViewController: UIViewController {
    
    private let underlineImage = UIImageView(image: UIImage(named: "imgMapLine"))
    private let downButton = UIButton()
    private let searchButton = UIButton()
    
    private let underlineImageForSmallTitle = UIImageView(image: UIImage(named: "imgMapLine"))
    
    @IBOutlet weak var tableView: UITableView! // table view
    
    var mapBookList: [MapBookStore] = [] // map data
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        self.downloadMapData()
        
        // iOS 11 버전 이상에서 실행
        if #available(iOS 11.0, *){
            self.navigationController?.navigationBar.addSubview(underlineImage)
            self.navigationController?.navigationBar.addSubview(downButton)
            self.navigationController?.navigationBar.addSubview(searchButton)
            
            underlineImage.clipsToBounds = true
            underlineImage.translatesAutoresizingMaskIntoConstraints = false
            
            downButton.setImage(UIImage(named: "icDownArrow"), for: .normal)
            downButton.clipsToBounds = true
            downButton.translatesAutoresizingMaskIntoConstraints = false
            downButton.addTarget(self, action: #selector(clickDownButton), for: .touchUpInside)
            
            searchButton.setImage(UIImage(named: "icSearch"), for: .normal)
            searchButton.clipsToBounds = true
            searchButton.translatesAutoresizingMaskIntoConstraints = false
            searchButton.addTarget(self, action: #selector(clickSearchButton), for: .touchUpInside)
            
            
            NSLayoutConstraint.activate([
                underlineImage.leftAnchor.constraint(equalTo: (self.navigationController?.navigationBar.leftAnchor)!, constant: 15),
                underlineImage.bottomAnchor.constraint(equalTo: (self.navigationController?.navigationBar.bottomAnchor)!, constant: -5),
                underlineImage.widthAnchor.constraint(equalToConstant: 88),
                
                downButton.leftAnchor.constraint(equalTo: (self.navigationController?.navigationBar.leftAnchor)!, constant: 100),
                downButton.bottomAnchor.constraint(equalTo: (self.navigationController?.navigationBar.bottomAnchor)!, constant: -10),
                downButton.widthAnchor.constraint(equalToConstant: 42),
                downButton.heightAnchor.constraint(equalToConstant: 42),
                
                searchButton.rightAnchor.constraint(equalToSystemSpacingAfter: (self.navigationController?.navigationBar.rightAnchor)!, multiplier: 300),
                searchButton.centerYAnchor.constraint(equalToSystemSpacingBelow: (self.navigationController?.navigationBar.centerYAnchor)!, multiplier: 0),
                searchButton.widthAnchor.constraint(equalToConstant: 48),
                searchButton.heightAnchor.constraint(equalToConstant: 48)
            ])
        }
    }
    
    // 서버 통신
    func downloadMapData(){
        MapService.shared.getMapBookStore(){ NetworkResult in
            switch NetworkResult {
            case .success(let data) :
                print("success 💖")
                
                guard let data = data as? [MapBookStore] else { return }
                
                for data in data {
                    self.mapBookList.append(MapBookStore(bookstoreIdx: data.bookstoreIdx, sectionIdx: data.sectionIdx, bookstoreName: data.bookstoreName, hashtag1: data.hashtag1, hashtag2: data.hashtag2, hashtag3: data.hashtag3, profile: data.profile, image1: data.image1, count: data.count, checked: data.checked))
                }
//                print(data)
//                print(self.mapBookList.count)
                self.tableView.reloadData()
            case .requestErr(_):
                print("Request error")
            case .pathErr:
                print("path error")
            case .serverErr:
                print("server error")
            case .networkFail:
                print("network error")
            }
        }
    }
    
    // 검색 버튼 클릭
    @objc func clickSearchButton(){
        let storybaord = UIStoryboard(name: "Search", bundle: nil)
        let vc = storybaord.instantiateViewController(identifier: "SearchViewController") as! SearchViewController
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    // 지역 선택 버튼 클릭
    @objc func clickDownButton(){
        let storybaord = UIStoryboard(name: "SelectRegion", bundle: nil)
        let pvc = storybaord.instantiateViewController(identifier: "SelectRegionViewController") as! SelectRegionViewController
        
        pvc.transitioningDelegate = self
        pvc.modalPresentationStyle = .custom
        
        present(pvc, animated: true, completion: nil)
    }
    
    // deselect table cell
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if let index = self.tableView.indexPathForSelectedRow {
            self.tableView.deselectRow(at: index, animated: true)
        }
    }
}

extension MapViewController: UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate, UIViewControllerTransitioningDelegate {
    // present half
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return HalfSizePresentationController(presentedViewController: presented, presenting: presenting)
    }
    
    // table view height 지정
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 86
        case 1:
            return 287
        default:
            return 0
        }
    }
    
    // set section number
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    // set section list
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if 0 == section {
            return 1
        } else {
            return self.mapBookList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell1") as! CountTableViewCell
            cell.countLabel.text = "마포구의 독립 서점 " + String(self.mapBookList.count) + "개"
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell2") as! LibraryTableViewCell
            cell.wholeView.setViewShadow()
            
            cell.tagView.setTagView()
            cell.tagView2.setTagView()
            cell.tagView3.setTagView()
            
            cell.bookstoreName.text = self.mapBookList[indexPath.row].bookstoreName
            
            let imageURL = URL(string: self.mapBookList[indexPath.row].image1)
            cell.bookstoreImageView.kf.setImage(with: imageURL)
            
            cell.tagLabel.text = self.mapBookList[indexPath.row].hashtag1
            cell.tagLabel2.text = self.mapBookList[indexPath.row].hashtag2
            cell.tagLabel3.text = self.mapBookList[indexPath.row].hashtag3
            
            return cell
        }
    }
    
    // cell click event 지정 - detail view 로 넘어가기
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            let storyboard = UIStoryboard(name: "MapDetail", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "MapDetailViewController") as! MapDetailViewController
            
            //            self.underlineImage.isHidden = true
            //            self.downButton.isHidden = true
            //
            //            self.navigationController?.pushViewController(vc, animated: true)
            
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
        }
    }
    
    // 스크롤 할 때마다 호출
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y <= 1 {
            self.underlineImage.isHidden = false
            self.downButton.isHidden = false
        } else {
            self.underlineImage.isHidden = true
            self.downButton.isHidden = true
        }
    }
    
    func scrollViewShouldScrollToTop(_ scrollView: UIScrollView) -> Bool {
        return true
    }
}

class HalfSizePresentationController : UIPresentationController {
    override var frameOfPresentedViewInContainerView: CGRect {
        get {
            guard let theView = containerView else {
                return CGRect.zero
            }
            return CGRect(x: 0, y: theView.bounds.height-306, width: theView.bounds.width, height: 306)
        }
    }
}
