//
//  MyPageViewController.swift
//  Cozy
//
//  Created by IJ . on 2020/07/03.
//  Copyright © 2020 jun. All rights reserved.
//

import UIKit

class MyPageViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    private var lastBookstoreList: [LastBookstore] = []
    let bookstore1 = LastBookstore(bookstoreImage: "37", bookstoreName: "퇴근길 책 한잔")
           let bookstore2 = LastBookstore(bookstoreImage: "39", bookstoreName: "지구불시착")
           let bookstore3 = LastBookstore(bookstoreImage: "40", bookstoreName: "책인감")
           let bookstore4 = LastBookstore(bookstoreImage: "37", bookstoreName: "퇴근길 책 한잔")
           let bookstore5 = LastBookstore(bookstoreImage: "39", bookstoreName: "지구불시착")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        lastBookstoreList = [bookstore1, bookstore2, bookstore3, bookstore4, bookstore5]
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

extension MyPageViewController: UICollectionViewDataSource {
    //셀에 들어가는 데이터 설정
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let lastBookstoreCell = collectionView.dequeueReusableCell(withReuseIdentifier:LastBookstoreCell.identifier, for:indexPath) as? LastBookstoreCell else {return UICollectionViewCell() }
        lastBookstoreCell.set(lastBookstoreList[indexPath.row])
        
        lastBookstoreCell.bookstoreImageView.layer.cornerRadius = 5
    
        return lastBookstoreCell
    }
    //섹션에 몇개 들어가는지
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return lastBookstoreList.count
    }
}

extension MyPageViewController: UICollectionViewDelegateFlowLayout {
    // 셀 height, width 지정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 92, height: 122)
    }
    // contentinset 지정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    // cell 위, 아래 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 17
    }
    // cell 좌, 우 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 9
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.scrollDirection = .horizontal
    }
}
