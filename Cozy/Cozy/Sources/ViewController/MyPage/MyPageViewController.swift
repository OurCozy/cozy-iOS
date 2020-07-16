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
    
    //유저 프로필
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var userNickname: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    
    
    
    // 프로필 사진 업로드
    var delegate: ButtonDelegate?
    var indexPath: IndexPath?
    private var pickerController = UIImagePickerController()
    
    // 내가 쓴 후기 뷰
    @IBOutlet weak var myReview: UIView!
    
    // 최근 본 책방
    var recentList: [recentBookstore] = []
    @IBOutlet weak var collectionView: UICollectionView!
    //    private var lastBookstoreList: [LastBookstore] = []
    //    let bookstore1 = LastBookstore(bookstoreImage: "37", bookstoreName: "퇴근길 책 한잔")
    //           let bookstore2 = LastBookstore(bookstoreImage: "39", bookstoreName: "지구불시착")
    //           let bookstore3 = LastBookstore(bookstoreImage: "40", bookstoreName: "책인감")
    //           let bookstore4 = LastBookstore(bookstoreImage: "37", bookstoreName: "퇴근길 책 한잔")
    //           let bookstore5 = LastBookstore(bookstoreImage: "39", bookstoreName: "지구불시착")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        pickerController.delegate = self
        
        // 내가 쓴 후기 탭제스쳐 연결
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer()
        tapGesture.delegate = self
        
        self.myReview.addGestureRecognizer(tapGesture)
        
        //        lastBookstoreList = [bookstore1, bookstore2, bookstore3, bookstore4, bookstore5]
        collectionView.dataSource = self
        collectionView.delegate = self
        
        addProfileData()
        setRecentData()
    }
    
    // 프로필 사진 서버 가져오기
    func setProfileData(profile: String, userNickname: String, userEmail: String){
        let url = URL(string: profile)
        guard let data = try? Data(contentsOf: url!) else {return}
        self.profileImage.image = UIImage(data: data)
        self.userNickname.text = userNickname
        self.userEmail.text = userEmail
    }
    
    // 프로필 사진 클릭시 사진앨범
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
    
    func addProfileData(){
        ProfileService.shared.getProfileData(){ NetworkResult in
            switch NetworkResult {
            case .success(let data):
                guard let data = data as? [UserProfile] else {return print("error")}
                print("@@@@@@data@@@@@@")
                print(data)
                self.setProfileData(profile: data[0].profile, userNickname: data[0].nickname, userEmail: data[0].email)
                
                // cell만
                //self.tableView.reloadData()
                
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
    
    // 최근 본 책방
    func setRecentData(){
        RecentService.shared.getRecentData(){ NetworkResult in
            switch NetworkResult {
            case .success(let data):
                guard let data = data as? [recentBookstore] else {return print("recenterror")}
                print("@@@recentdata@@@@@@")
                print(data)
                for data in data{
                    self.recentList.append(recentBookstore(bookstoreIdx: data.bookstoreIdx, bookstoreName: data.bookstoreName, profile: data.profile, image1: data.image1))
                }
                
                
//                print("데이터어 \(self.recentList[0])")
//                print("데이터어 \(self.recentList[1])")
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
                
            // 디코딩에러
            case .requestErr(_):
                print("Recent Request error@@")
            case .pathErr:
                print("recent path error")
            case .serverErr:
                print("recent server error")
            case .networkFail:
                print("recent network error")
            }
        }
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
        
        
        lastBookstoreCell.bookstoreImageView.layer.cornerRadius = 5
        
        lastBookstoreCell.bookstoreImageView.setImage(from: self.recentList[indexPath.row].image1)
        lastBookstoreCell.nameLabel.text = self.recentList[indexPath.row].bookstoreName
        
        
        return lastBookstoreCell
    }
    //섹션에 몇개 들어가는지
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recentList.count
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
