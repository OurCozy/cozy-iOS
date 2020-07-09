//
//  MapViewController.swift
//  Cozy
//
//  Created by IJ . on 2020/07/03.
//  Copyright © 2020 jun. All rights reserved.
//

import UIKit

// search image const
private struct Const {
    static let ImageSizeForLargeState: CGFloat = 40
    static let ImageRightMargin: CGFloat = 16
    static let ImageBottomMarginForLargeState: CGFloat = 12
    static let ImageBottomMarginForSmallState: CGFloat = 6
    static let ImageSizeForSmallState: CGFloat = 32
    static let NavBarHeightSmallState: CGFloat = 44
    static let NavBarHeightLargeState: CGFloat = 96.5
}

class MapViewController: UIViewController {
    
    private let searchImage = UIImageView(image: UIImage(named: "icSearch")) // search image
    private let underlineView = UIView(frame: CGRect(x: 17, y: 98, width: 85, height: 2))
    let downButton = UIButton(frame: CGRect(x: 100, y: 55, width: 42, height: 42))
    
    @IBOutlet weak var tableView: UITableView! // table view
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // iOS 11 버전 이상에서 실행
        if #available(iOS 11.0, *){
            self.navigationController?.navigationBar.prefersLargeTitles = true
            
            // insert searchImage
            self.navigationController?.navigationBar.addSubview(searchImage)
            
            // add imageview click event
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(searchImageTapped))
            searchImage.isUserInteractionEnabled = true
            searchImage.addGestureRecognizer(tapGestureRecognizer)
            
            searchImage.layer.cornerRadius = Const.ImageSizeForLargeState / 2
            searchImage.clipsToBounds = true
            searchImage.translatesAutoresizingMaskIntoConstraints = false
            
            // insert underline view
            underlineView.layer.backgroundColor = UIColor.dustyOrange.cgColor
            self.navigationController?.navigationBar.addSubview(underlineView)
            
            // insert down arrow button
            downButton.setImage(UIImage(named: "icDownArrow"), for: .normal)
            self.navigationController?.navigationBar.addSubview(downButton)
            self.downButton.addTarget(self, action: #selector(clickDownButton), for: .touchUpInside)
            
            // search image 지정
            NSLayoutConstraint.activate([
                searchImage.rightAnchor.constraint(equalTo: (self.navigationController?.navigationBar.rightAnchor)!, constant: -Const.ImageRightMargin),
                searchImage.bottomAnchor.constraint(equalTo: (self.navigationController?.navigationBar.bottomAnchor)!, constant: -Const.ImageBottomMarginForLargeState),
                searchImage.heightAnchor.constraint(equalToConstant: Const.ImageSizeForLargeState),
                searchImage.widthAnchor.constraint(equalTo: searchImage.heightAnchor),
            ])
        }
    }
    
    // 지역 선택 버튼 클릭
    @objc func clickDownButton(){
        let storybaord = UIStoryboard(name: "SelectRegion", bundle: nil)
        let pvc = storybaord.instantiateViewController(identifier: "SelectRegionViewController") as! SelectRegionViewController
        
        pvc.transitioningDelegate = self
        pvc.modalPresentationStyle = .custom
        
        present(pvc, animated: true, completion: nil)
    }
    
    // search image click event
    @objc func searchImageTapped(tapGestureRecognizer: UITapGestureRecognizer){
        let storyboard = UIStoryboard(name: "Search", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
        
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
            return 5
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell1") as! CountTableViewCell
            cell.countLabel.text = "마포구의 독립 서점 87곳"
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell2") as! LibraryTableViewCell
            cell.wholeView.setViewShadow()
            
            cell.tagView.setTagView()
            cell.tagView2.setTagView()
            cell.tagView3.setTagView()
            
            cell.tagLabel.text = "감성타코"
            cell.tagLabel2.text = "독립서점"
            cell.tagLabel3.text = "독립서점"
            
            return cell
        }
    }
    
    // cell click event 지정 - detail view 로 넘어가기
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            let storyboard = UIStoryboard(name: "MapDetail", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "MapDetailViewController") as! MapDetailViewController
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
        }
    }
    
    // 처음 스크롤 시작할 때 한 번만 호출
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.underlineView.isHidden = true
        self.downButton.isHidden = true
    }
    
    // 스크롤 종료시 한 번만 호출
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y == 0 {
            self.underlineView.isHidden = false
            self.downButton.isHidden = false
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

            return CGRect(x: 0, y: theView.bounds.height/2, width: theView.bounds.width, height: theView.bounds.height/2)
        }
    }
}
