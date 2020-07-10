//
//  MapDetailViewController.swift
//  Cozy
//
//  Created by 최은지 on 2020/07/05.
//  Copyright © 2020 jun. All rights reserved.
//

import UIKit
import MapKit

class MapDetailViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    let scrollTopEdgeInsets: CGFloat = 210
    
    @IBOutlet weak var bookstoreImageView: UIImageView!
    
    @IBOutlet weak var tagButton1: UIButton!
    @IBOutlet weak var tagButton2: UIButton!
    @IBOutlet weak var tagButton3: UIButton!
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var explainLabel: UILabel!
    
    @IBOutlet weak var mapView: MKMapView!
    
    let eunpyeongLoc = CLLocationCoordinate2D(latitude: 37.6176125, longitude: 126.9227004) // 은평구 (샘플 서점 위치)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setTagButtonUI()
        self.setTimeLabel()
        self.setExplainLabel()
        
        self.mapView.mapType = MKMapType.standard
        self.setMapView(coordinate: eunpyeongLoc, addr:"안도북스")
        
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.delegate = self
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
    
    @IBAction func clickBackButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
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

        let timeString1 = NSAttributedString(string: "평일 13:00 ~ 19:00(화-토) \n", attributes: [.font : UIFont.systemFont(ofSize: 14)])
        let timeString2 = NSAttributedString(string: "공휴일 00:00~24:00(일,월 휴무) \n", attributes: [.font : UIFont.systemFont(ofSize: 14)])
        let timeString3 = NSAttributedString(string: "시간 변동 가능 \n", attributes: [.font : UIFont.systemFont(ofSize: 14)])

        let attrString = NSMutableAttributedString()
        attrString.append(timeString1)
        attrString.append(timeString2)
        attrString.append(timeString3)

        attrString.addAttributes([.paragraphStyle : style], range: NSMakeRange(0, attrString.length))

        self.timeLabel.attributedText = attrString
        
    }
    
    func setExplainLabel(){
        self.explainLabel.numberOfLines = 0
        self.explainLabel.text = """
            스토리지북앤필름 너무 좋은 독립서점이에요. 해방촌의 분위기를
            좋아하는데 이 책방이 한 몫하는것 같아요. 골목길에 있지만 일부러
            찾아오는 책방입니다! 대형서점에 없는 책들도 많고 가게 자체도
        """
    }
    
    @IBAction func clickBookMarkButton(_ sender: UIButton) {
        sender.setImage(UIImage(named: "icBookmarkSelected"), for: .normal)
    }
    
    // 스크롤 애니메이션 지정
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let yPosition = scrollView.contentOffset.y
        
        if yPosition < 0 {
           // 위로 스크롤
        } else {
            // 아래로 스크롤
        }
    }
    
}

