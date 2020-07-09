//
//  SelectRegionViewController.swift
//  Cozy
//
//  Created by 최은지 on 2020/07/09.
//  Copyright © 2020 jun. All rights reserved.
//

import UIKit

class SelectRegionViewController: UIViewController {
    
    @IBOutlet weak var regionButton1: UIButton!
    @IBOutlet weak var regionButton2: UIButton!
    @IBOutlet weak var regionButton3: UIButton!
    @IBOutlet weak var regionButton4: UIButton!
    @IBOutlet weak var regionButton5: UIButton!
    @IBOutlet weak var regionButton6: UIButton!
    
    @IBOutlet weak var seoulUnderline: UIView!
    @IBOutlet weak var gyeongiUnderline: UIView!
    
    @IBOutlet weak var buttonView: UIStackView!
    
    var readyLabel = UILabel()
    var backButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setRegionButtons()
        self.gyeongiUnderline.isHidden = true
    }
    
    // 서울 버튼 클릭
    @IBAction func selectSeoulButton(_ sender: UIButton) {
        self.seoulUnderline.isHidden = false
        self.gyeongiUnderline.isHidden = true
        self.isHideButtons(isHidden: false)
        
        self.readyLabel.isHidden = true
//        self.backButton.isHidden = true
    }
    
    // 경기 버튼 클릭
    @IBAction func selectGyeongiButton(_ sender: UIButton) {
        self.seoulUnderline.isHidden = true
        self.gyeongiUnderline.isHidden = false
        self.readyLabel.isHidden = false
        self.isHideButtons(isHidden: true)
        
        self.addReadyLabel()
//        self.addBackButton()
    }
    
    func addReadyLabel(){
        self.readyLabel.numberOfLines = 2
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 2.0
        style.alignment = .center
        let timeString1 = NSAttributedString(string: "아직 준비중이에요! \n잠시만 기다려주세요!", attributes: [.font : UIFont.systemFont(ofSize: 20, weight: .bold)])
        let attrString = NSMutableAttributedString()
        attrString.append(timeString1)
        attrString.addAttributes([.paragraphStyle : style], range: NSMakeRange(0, attrString.length))
        self.readyLabel.attributedText = attrString
        
        self.readyLabel.frame = CGRect(x: 0, y: 120, width: self.view.frame.width, height: 53)
        self.view.addSubview(readyLabel)
    }
    
    func addBackButton(){
        self.backButton.frame = CGRect(x: 0, y: 234, width: 100, height: 100)
        self.backButton.setTitle("돌아가기", for: .normal)
        
        self.view.addSubview(backButton)
    }
    
    // 지역 선택
    @IBAction func clickRegionButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    

    // button UI 설정
    func setRegionButtons(){
        self.regionButton1.setRegionButton()
        self.regionButton2.setRegionButton()
        self.regionButton3.setRegionButton()
        self.regionButton4.setRegionButton()
        self.regionButton5.setRegionButton()
        self.regionButton6.setRegionButton()
    }
    
    func isHideButtons(isHidden: Bool){
        if isHidden {
            self.buttonView.isHidden = true
        } else {
            self.buttonView.isHidden = false
        }
    }
    
    
}
