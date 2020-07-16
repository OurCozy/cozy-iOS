//
//  SearchListViewController.swift
//  Cozy
//
//  Created by 최은지 on 2020/07/16.
//  Copyright © 2020 jun. All rights reserved.
//

import UIKit

class SearchListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
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
    
}

extension SearchListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 291
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell") as! SearchListTableViewCell
        
        cell.wholeView.setViewShadow()
        
        cell.bookstoreImageView.roundCorners([.topLeft, .topRight], radius: 10)
        
//        cell.bookstoreImageView.roundCorners([.topLeft, .topRight], radius: 10)
        
        
        cell.hashtag1.setTagView()
        cell.hashtag2.setTagView()
        cell.hashtag3.setTagView()
        
        return cell
        
    }
    
    
}
