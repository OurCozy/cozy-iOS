//
//  SearchListViewController.swift
//  Cozy
//
//  Created by 최은지 on 2020/07/16.
//  Copyright © 2020 jun. All rights reserved.
//

import UIKit
import Kingfisher

class SearchListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var mainLabel: UILabel!
    
    var searchRegion: String = ""
    var searchList: [SearchBookStore] = [] // 검색 리스트
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.mainLabel.text = self.searchRegion
        self.downloadSearchData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    @IBAction func goBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func downloadSearchData(){
        SearchService.shared.searchBookStore(searchRegion: self.searchRegion) { NetworkResult in
            
            switch NetworkResult {
            case .success(let data) :
                self.searchList = []
                guard let data = data as? [SearchBookStore] else { return }
                for data in data {
                    self.searchList.append(SearchBookStore(bookstoreIdx: data.bookstoreIdx, bookstoreName: data.bookstoreName, latitude: data.latitude, longitude: data.longitude, location: data.location, sectionIdx: data.sectionIdx, tel: data.tel, instagram: data.instagram, facebook: data.facebook, homepage: data.homepage, time: data.time, dayoff: data.dayoff, changeable: data.changeable, activity: data.activity, shortIntro: data.shortIntro, shortIntro2: data.shortIntro2, description: data.description, bookmark: data.bookmark, profile: data.profile, hashtag1: data.hashtag1, hashtag2: data.hashtag2, hashtag3: data.hashtag3, image1: data.image1))
                }
                print("success🤩")
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
    
}

extension SearchListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 291
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.searchList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell") as! SearchListTableViewCell
        
        cell.wholeView.setViewShadow()
        cell.bookstoreImageView.roundCorners([.topLeft, .topRight], radius: 10)
        cell.hashtag1.setTagView()
        cell.hashtag2.setTagView()
        cell.hashtag3.setTagView()
        
        cell.bookstoreLabel.text = self.searchList[indexPath.row].bookstoreName
        
        let imgURLstr = self.searchList[indexPath.row].image1
        let imgURL = URL(string: imgURLstr)
        
        cell.bookstoreImageView.kf.setImage(with: imgURL)
        
        cell.hashtag1.text = self.searchList[indexPath.row].hashtag1
        cell.hashtag2.text = self.searchList[indexPath.row].hashtag2
        cell.hashtag3.text = self.searchList[indexPath.row].hashtag3
        
        return cell
    }
    
}
