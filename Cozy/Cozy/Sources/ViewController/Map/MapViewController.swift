//
//  MapViewController.swift
//  Cozy
//
//  Created by IJ . on 2020/07/03.
//  Copyright © 2020 jun. All rights reserved.
//

import UIKit

// image const
private struct Const {
    static let ImageSizeForLargeState: CGFloat = 40
    static let ImageRightMargin: CGFloat = 16
    static let ImageBottomMarginForLargeState: CGFloat = 12
    static let ImageBottomMarginForSmallState: CGFloat = 6
    static let ImageSizeForSmallState: CGFloat = 32
    static let NavBarHeightSmallState: CGFloat = 44
    static let NavBarHeightLargeState: CGFloat = 96.5
}

// TODO : navigation bar 밑줄 추가
// underline const
private struct Const2 {
    // large state
    static let ViewWidthSizeForLargeState: CGFloat = 75
    static let ViewHeightSizeForLargeState: CGFloat = 3
    static let ViewLeftMarginForLargeState: CGFloat = 24
    static let ViewBottomMarginForLargeState: CGFloat = 28
    // small state
    static let ViewWidthSizeForSmallState: CGFloat = 12
}

class MapViewController: UIViewController {
    
    private let searchImage = UIImageView(image: UIImage(named: "icSearch")) // search image
    private let underlineView = UIView(frame: CGRect(x: 17, y: 100, width: 75, height: 3))
    
    @IBOutlet weak var tableView: UITableView! // table view
    
    var sampleItems: [String] = ["hello1", "hello2", "hello3", "hello5"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        if #available(iOS 11.0, *){
            self.navigationController?.navigationBar.prefersLargeTitles = true
            
            // insert searchImage
            self.navigationController?.navigationBar.addSubview(searchImage)
            
            // add imageview click event
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(searchImageTapped))
            searchImage.isUserInteractionEnabled = true
            searchImage.addGestureRecognizer(tapGestureRecognizer)
            
            // insert underline
//            underlineView.layer.backgroundColor = UIColor.dustyOrange.cgColor

            searchImage.layer.cornerRadius = Const.ImageSizeForLargeState / 2
            searchImage.clipsToBounds = true
            searchImage.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                searchImage.rightAnchor.constraint(equalTo: (self.navigationController?.navigationBar.rightAnchor)!, constant: -Const.ImageRightMargin),
                searchImage.bottomAnchor.constraint(equalTo: (self.navigationController?.navigationBar.bottomAnchor)!, constant: -Const.ImageBottomMarginForLargeState),
                searchImage.heightAnchor.constraint(equalToConstant: Const.ImageSizeForLargeState),
                searchImage.widthAnchor.constraint(equalTo: searchImage.heightAnchor),
            ])
        }
    }
    
    // search image click event
    @objc func searchImageTapped(tapGestureRecognizer: UITapGestureRecognizer){
        print("click search image!")
        
        let storyboard = UIStoryboard(name: "Search", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
        
    }
}

extension MapViewController: UITableViewDelegate, UITableViewDataSource {
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if 0 == section {
            return 1
        } else {
            return sampleItems.count
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

}
