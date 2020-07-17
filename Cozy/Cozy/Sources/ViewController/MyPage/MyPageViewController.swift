//
//  MyPageViewController.swift
//  Cozy
//
//  Created by IJ . on 2020/07/03.
//  Copyright © 2020 jun. All rights reserved.
//

import UIKit


class MyPageViewController: UIViewController, UIGestureRecognizerDelegate {
    
    //유저 프로필
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var userNickname: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    
    
    // 프로필 사진 업로드
    private var pickerController = UIImagePickerController()
    
    // 내가 쓴 후기 뷰
    @IBOutlet weak var myReview: UIView!
    
    // 최근 본 책방
    var recentList: [recentBookstore] = []
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        profileImage.layer.cornerRadius = 40
        profileImage.layer.borderWidth = 1
        profileImage.layer.borderColor = UIColor.clear.cgColor
        
        pickerController.delegate = self
        
        // 내가 쓴 후기 탭제스쳐 연결
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer()
        tapGesture.delegate = self
        
        self.myReview.addGestureRecognizer(tapGesture)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        addProfileData()
        setRecentData()
        
        
    }
    
    // 최근 본 책방 바로 보이게
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setRecentData()
    }
    
    // 프로필 가져오기
    func setProfileData(profile: String, userNickname: String, userEmail: String){
           let url = URL(string: profile)
           guard let data = try? Data(contentsOf: url!) else {return}
           self.profileImage.image = UIImage(data: data)
           self.userNickname.text = userNickname
           self.userEmail.text = userEmail
       }
    
    @IBAction func setProfileBtn(_ sender: Any) {
                let alertController = UIAlertController(title: "사진 선택", message: "가져올 곳을 선택하세요", preferredStyle: .actionSheet)
                let galleryAction = UIAlertAction(title: "사진 보관함", style: .default) { action in self.openLibrary() }
                let photoAction = UIAlertAction(title: "카메라", style: .default) { action in self.openCamera() }
                let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
                alertController.addAction(galleryAction)
                alertController.addAction(photoAction)
                alertController.addAction(cancelAction)
                self.present(alertController, animated: true, completion: nil)
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
    
    // upload profile
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage, let url = info[UIImagePickerController.InfoKey.imageURL] as? URL {
            
            guard let token = UserDefaults.standard.object(forKey: "token") as? String else { return }
            UploadService.shared.uploadImage(token, image, url.lastPathComponent) { networkResult in
                switch networkResult {
                case .success(let profileData):
                    guard let profileData = profileData as? [UserProfile] else { return }
                    print(profileData[0].profile)
                    
                case .requestErr(let failMessage):
                    guard let message = failMessage as? String else { return }
                    print(message)
                case .pathErr:
                    print("pathErr")
                case .serverErr:
                    print("serverErr")
                case .networkFail:
                    print("networkFail")
                }
            }
            profileImage.image = image
        }
        dismiss(animated: true, completion: nil)
    }
    
    // 최근 본 책방
    func setRecentData(){
        RecentService.shared.getRecentData(){ NetworkResult in
            switch NetworkResult {
            case .success(let data):
                guard let data = data as? [recentBookstore] else {return print("recenterror")}
                print("@@@recentdata@@@@@@")
                print(data)
                // 최근 본 책방 바로 뜨게
                self.recentList.removeAll()
                for data in data{
                    self.recentList.append(recentBookstore(bookstoreIdx: data.bookstoreIdx, bookstoreName: data.bookstoreName, profile: data.profile, image1: data.image1))
                }
             
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
                
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
//        if recentList.count == 0 {
//        //            tableView.setEmptyView(title: self.nickName + "님만의 책방을 콕! 해볼까요?", message: "책방이 비어있습니다!")
//                    collectionView.setEmptyView(title: "", message: "책방이 비어있습니다!")
//                }
//                else {
//                    collectionView.restore()
//                }
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
