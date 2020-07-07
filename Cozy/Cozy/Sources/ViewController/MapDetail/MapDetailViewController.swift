//
//  MapDetailViewController.swift
//  Cozy
//
//  Created by 최은지 on 2020/07/05.
//  Copyright © 2020 jun. All rights reserved.
//

import UIKit

class MapDetailViewController: UIViewController {

    @IBOutlet weak var bookstoreImageView: UIImageView!
    
    @IBOutlet weak var tagButton1: UIButton!
    @IBOutlet weak var tagButton2: UIButton!
    @IBOutlet weak var tagButton3: UIButton!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var explainLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setTagButtonUI()
        self.setTimeLabel()
        self.setExplainLabel()
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
}
