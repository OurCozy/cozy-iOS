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
    /// Image height/width for Large NavBar state
    static let ImageSizeForLargeState: CGFloat = 40
    /// Margin from right anchor of safe area to right anchor of Image
    static let ImageRightMargin: CGFloat = 16
    /// Margin from bottom anchor of NavBar to bottom anchor of Image for Large NavBar state
    static let ImageBottomMarginForLargeState: CGFloat = 12
    /// Margin from bottom anchor of NavBar to bottom anchor of Image for Small NavBar state
    static let ImageBottomMarginForSmallState: CGFloat = 6
    /// Image height/width for Small NavBar state
    static let ImageSizeForSmallState: CGFloat = 32
    /// Height of NavBar for Small state. Usually it's just 44
    static let NavBarHeightSmallState: CGFloat = 44
    /// Height of NavBar for Large state. Usually it's just 96.5 but if you have a custom font for the title, please make sure to edit this value since it changes the height for Large state of NavBar
    static let NavBarHeightLargeState: CGFloat = 96.5
}


class MapViewController: UIViewController {
    
    private let searchImage = UIImageView(image: UIImage(named: "icSearch")) // search image
    
    @IBOutlet weak var tableView: UITableView! // table view
    
    var sampleItems: [String] = ["hello1", "hello2", "hello3"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        if #available(iOS 11.0, *){
            self.navigationController?.navigationBar.prefersLargeTitles = true
            self.navigationController?.navigationBar.addSubview(searchImage)
            
            searchImage.layer.cornerRadius = Const.ImageSizeForLargeState / 2
            searchImage.clipsToBounds = true
            searchImage.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                searchImage.rightAnchor.constraint(equalTo: (self.navigationController?.navigationBar.rightAnchor)!, constant: -Const.ImageRightMargin),
                searchImage.bottomAnchor.constraint(equalTo: (self.navigationController?.navigationBar.bottomAnchor)!, constant: -Const.ImageBottomMarginForLargeState),
                searchImage.heightAnchor.constraint(equalToConstant: Const.ImageSizeForLargeState),
                searchImage.widthAnchor.constraint(equalTo: searchImage.heightAnchor)
            ])
            
            
            //            self.navigationController?.navigationBar.backgroundColor
            //            let navBarHeight = UIApplication.shared.statusBarFrame.size.height +
            //            (navigationController?.navigationBar.frame.height ?? 0.0)
            //            print(navBarHeight)
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        if let index = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: index, animated: true)
        }
    }
    
}

extension MapViewController: UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    
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
            
            return cell
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if tableView.contentOffset.y == 0 {
            // 가장 상단에 있을 때
            // button.isHidden = false
        }
        else {
            // 가장 상단이 아닐 때
        }
    }
}
