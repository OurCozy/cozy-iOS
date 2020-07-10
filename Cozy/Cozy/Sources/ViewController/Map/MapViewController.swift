//
//  MapViewController.swift
//  Cozy
//
//  Created by IJ . on 2020/07/03.
//  Copyright © 2020 jun. All rights reserved.
//

import UIKit

class MapViewController: UIViewController {
    
    private let searchImage = UIImageView(image: UIImage(named: "icSearch")) // search image
    
    private let underlineImage = UIImageView(image: UIImage(named: "imgMapLine"))
    private let downButton = UIButton()
    
    private let underlineImageForSmallTitle = UIImageView(image: UIImage(named: "imgMapLine"))
    
    @IBOutlet weak var searchButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView! // table view
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        self.searchButton.tintColor = UIColor.gray
        
        // iOS 11 버전 이상에서 실행
        if #available(iOS 11.0, *){
            self.navigationController?.navigationBar.addSubview(underlineImage)
            self.navigationController?.navigationBar.addSubview(downButton)
            
            underlineImage.clipsToBounds = true
            underlineImage.translatesAutoresizingMaskIntoConstraints = false
            
            downButton.setImage(UIImage(named: "icDownArrow"), for: .normal)
            downButton.clipsToBounds = true
            downButton.translatesAutoresizingMaskIntoConstraints = false
            downButton.addTarget(self, action: #selector(clickDownButton), for: .touchUpInside)
            
            NSLayoutConstraint.activate([
                underlineImage.leftAnchor.constraint(equalTo: (self.navigationController?.navigationBar.leftAnchor)!, constant: 15),
                underlineImage.bottomAnchor.constraint(equalTo: (self.navigationController?.navigationBar.bottomAnchor)!, constant: -10),
                underlineImage.widthAnchor.constraint(equalToConstant: 88),
                
                downButton.leftAnchor.constraint(equalTo: (self.navigationController?.navigationBar.leftAnchor)!, constant: 100),
                downButton.bottomAnchor.constraint(equalTo: (self.navigationController?.navigationBar.bottomAnchor)!, constant: -10),
                downButton.widthAnchor.constraint(equalToConstant: 42),
                downButton.heightAnchor.constraint(equalToConstant: 42)
            ])
        }
    }
    
    @IBAction func searchButtonClick(_ sender: UIBarButtonItem) {
        let storybaord = UIStoryboard(name: "SelectRegion", bundle: nil)
        let pvc = storybaord.instantiateViewController(identifier: "SelectRegionViewController") as! SelectRegionViewController
        
        pvc.transitioningDelegate = self
        pvc.modalPresentationStyle = .custom
        
        present(pvc, animated: true, completion: nil)
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
