//
//  MyPageViewController.swift
//  Cozy
//
//  Created by IJ . on 2020/07/03.
//  Copyright © 2020 jun. All rights reserved.
//

import UIKit

protocol ButtonDelegate {
    func onClickButton(in index: Int)
}

class MyPageViewController: UIViewController, UIGestureRecognizerDelegate {

    // 프로필 사진
    var delegate: ButtonDelegate?
    var indexPath: IndexPath?
    private var pickerController = UIImagePickerController()
    
    // 내가 쓴 후기 뷰
    @IBOutlet weak var myReview: UIView!
    
    // 최근 본 책방
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
        
        pickerController.delegate = self
        
        // 내가 쓴 후기 탭제스쳐 연결
         let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer()
         tapGesture.delegate = self
         
         self.myReview.addGestureRecognizer(tapGesture)

        lastBookstoreList = [bookstore1, bookstore2, bookstore3, bookstore4, bookstore5]
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
        @IBAction func touchUpProfileButton(_ sender: Any) {
            delegate?.onClickButton(in: indexPath!.row)
        }
    
    // 공지사항 이동
    @IBAction func gotoNotice(_ sender: UIButton) {
        let sb = UIStoryboard(name: "MyPage", bundle: nil)
        let vc = sb.instantiateViewController(identifier: "NoticeViewController") as! NoticeViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    // 이벤트 이동
    @IBAction func gotoEvent(_ sender: UIButton) {
        let sb = UIStoryboard(name: "MyPage", bundle: nil)
        let vc = sb.instantiateViewController(identifier: "EventViewController") as! EventViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    

    // 내가 쓴 후기
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        let storyboard  = UIStoryboard(name: "MyPage", bundle: nil)
        let vc  = storyboard.instantiateViewController(withIdentifier: "MyReviewViewController")
        self.navigationController!.pushViewController(vc, animated: true)
        return true
    }
}

 
extension MyPageViewController: ButtonDelegate {
    func onClickButton(in index: Int) {
        let alertController = UIAlertController(title: "사진 선택", message: "", preferredStyle: .actionSheet)
        let galleryAction = UIAlertAction(title: "사진 보관함", style: .default) { action in self.openLibrary() }
        let photoAction = UIAlertAction(title: "카메라", style: .default) { action in self.openCamera() }
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        alertController.addAction(photoAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
}

// 프로필 사진 사진함, 카메라 접근
extension MyPageViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func openLibrary() {
        pickerController.sourceType = .photoLibrary
        self.present(pickerController, animated: true, completion: nil)
    }
    func openCamera() {
        pickerController.sourceType = .camera
        self.present(pickerController, animated: true, completion: nil)
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
    // 가로 스크롤
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.scrollDirection = .horizontal
    }
}
