//
//  MapDetailViewController.swift
//  Cozy
//
//  Created by 최은지 on 2020/07/05.
//  Copyright © 2020 jun. All rights reserved.
//

import UIKit
import MapKit
import Kingfisher

class MapDetailViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    let scrollTopEdgeInsets: CGFloat = 210
    
    @IBOutlet weak var bookstoreImageView: UIImageView!
    @IBOutlet weak var bookstoreName: UILabel!
    
    @IBOutlet weak var addressLabel: UILabel!
    
    @IBOutlet weak var tagButton1: UIButton!
    @IBOutlet weak var tagButton2: UIButton!
    @IBOutlet weak var tagButton3: UIButton!
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var explainLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var activityLabel: UILabel!
    
    @IBOutlet weak var bookstoreImage2: UIImageView!
    @IBOutlet weak var bookstoreImage3: UIImageView!
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var reviewLabel1: UILabel!
    @IBOutlet weak var reviewLabel2: UILabel!
    
    @IBOutlet weak var reviewImageView1: UIImageView!
    @IBOutlet weak var reviewImageView2: UIImageView!
    
    @IBOutlet weak var moreButton: UIButton!
    
    var detailBookStoreModel: [DetailBookStoreModel.BookData] = []
    
    var bookstoreIdx: Int = 13
    
    let eunpyeongLoc = CLLocationCoordinate2D(latitude: 37.6176125, longitude: 126.9227004) // 은평구 (샘플 서점 위치)
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setTagButtonUI()
        
        self.mapView.mapType = MKMapType.standard
        self.setMapView(coordinate: eunpyeongLoc, addr:"안도북스")
        
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.delegate = self
        
        self.setReviewLabel()
        self.moreButton.settagButton()
        
        self.downloadMapDetail()
    }
    
    func downloadMapDetail(){
        self.detailBookStoreModel = []
        
        DetailBookStoreService.shared.getDetailBookStoreData(bookstoreIndex: self.bookstoreIdx){ NetworkResult in
            switch NetworkResult {
            case .success(let data):
                guard let data = data as? [DetailBookStoreModel.BookData] else { return }
                self.detailBookStoreModel = data
                
                self.updateView()
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
    
    // 데이터에 맞게 뷰 정보 update
    func updateView(){
        
        let urlString = self.detailBookStoreModel[0].image1
        let imageURL = URL(string: urlString)
        self.bookstoreImageView.kf.setImage(with: imageURL)
        
        self.bookstoreName.text = self.detailBookStoreModel[0].bookstoreName
        
        self.tagButton1.setTitle(self.detailBookStoreModel[0].hashtag1, for: .normal)
        self.tagButton2.setTitle(self.detailBookStoreModel[0].hashtag2, for: .normal)
        self.tagButton3.setTitle(self.detailBookStoreModel[0].hashtag3, for: .normal)
        
        self.addressLabel.text = self.detailBookStoreModel[0].location
        self.setTimeLabel()
        self.phoneLabel.text = self.detailBookStoreModel[0].tel
        self.activityLabel.text = self.detailBookStoreModel[0].activity
        
        let imgurlStr2 = self.detailBookStoreModel[0].image2
        let imgurlStr3 = self.detailBookStoreModel[0].image3
        let imgURL2 = URL(string: imgurlStr2)
        let imgURL3 = URL(string: imgurlStr3)
        
        self.bookstoreImage2.kf.setImage(with: imgURL2)
        self.bookstoreImage3.kf.setImage(with: imgURL3)
        
        self.setExplainLabel()
        
    }
    
    @IBAction func goBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func setReviewLabel(){
        
        self.reviewLabel1.numberOfLines = 0
        self.reviewLabel2.numberOfLines = 0
        
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 3.0
        
        let reviewText = NSAttributedString(string: "안도북스는 제가 자주 가는 서점입니다. 안도북스의 분위기를 좋아하고, 책방 속의 작은 소품들과 따뜻한 조명이 퇴근후의 저를 위로하는 것 같아서 자주 방문하는 곳이에요. 퇴근하고 바로 달려가기 조금 빠듯한 시간이지만 자주 찾는 책방입니다. ", attributes: [.font : UIFont.systemFont(ofSize: 12)])
        
        let attrString = NSMutableAttributedString()
        attrString.append(reviewText)
        
        attrString.addAttributes([.paragraphStyle : style], range: NSMakeRange(0, attrString.length))
        
        self.reviewLabel1.attributedText = attrString
        self.reviewLabel2.attributedText = attrString
        
        self.reviewImageView1.layer.cornerRadius = 5
        self.reviewImageView2.layer.cornerRadius = 5
    }
    
    // 더보기 버튼 클릭
    @IBAction func clickDetailButton(_ sender: UIButton) {
        
    }
    
    // 리뷰 버튼 클릭
    @IBAction func goReview(_ sender: UIButton) {
        
    }
    
    @IBAction func writeReview(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Review", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ReviewViewController") as! ReviewViewController
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func goNaverMap(_ sender: UIButton) {
        // bundle id : gamsung.Cozy
        let naverMapURL = URL(string: "nmap://map?&appname=com.example.myapp")
        
        UIApplication.shared.open(naverMapURL!, options: [:], completionHandler: nil)
    }
    
    func setMapView(coordinate: CLLocationCoordinate2D, addr: String){
        let region = MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta:0.01, longitudeDelta:0.01))
        self.mapView.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = addr
        self.mapView.addAnnotation(annotation)
    }
    
    
    func setTagButtonUI(){
        self.tagButton1.settagButton()
        self.tagButton2.settagButton()
        self.tagButton3.settagButton()
    }
    
    func setTimeLabel(){
        self.timeLabel.numberOfLines = 4
        
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 6.0
        
        let timeString1 = NSAttributedString(string: self.detailBookStoreModel[0].time + "\n", attributes: [.font : UIFont.systemFont(ofSize: 14)])
        let timeString2 = NSAttributedString(string: self.detailBookStoreModel[0].dayoff + "\n", attributes: [.font : UIFont.systemFont(ofSize: 14)])
        let timeString3 = NSAttributedString(string: self.detailBookStoreModel[0].changeable + "", attributes: [.font : UIFont.systemFont(ofSize: 14)])
        
        let attrString = NSMutableAttributedString()
        attrString.append(timeString1)
        attrString.append(timeString2)
        attrString.append(timeString3)
        
        attrString.addAttributes([.paragraphStyle : style], range: NSMakeRange(0, attrString.length))
        
        self.timeLabel.attributedText = attrString
    }
    
    func setExplainLabel(){
        self.explainLabel.numberOfLines = 0
        
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 3.0
        
        let reviewText = NSAttributedString(string: self.detailBookStoreModel[0].description + "", attributes: [.font : UIFont.systemFont(ofSize: 12)])
        
        let attrString = NSMutableAttributedString()
        attrString.append(reviewText)
        
        attrString.addAttributes([.paragraphStyle : style], range: NSMakeRange(0, attrString.length))
        
        self.explainLabel.attributedText = attrString
    }
    
    @IBAction func clickBookMarkButton(_ sender: UIButton) {
        sender.setImage(UIImage(named: "icBookmarkSelected"), for: .normal)
    }
    
}

