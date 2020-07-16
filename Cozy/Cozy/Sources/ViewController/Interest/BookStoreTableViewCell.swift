//
//  BookStoreTableViewCell.swift
//  Cozy
//
//  Created by 양재욱 on 2020/07/05.
//  Copyright © 2020 jun. All rights reserved.
//

import UIKit

protocol ButtonActionDelegate {
    func bookmarkButtonClick(at indexPath: IndexPath)
}

class BookStoreTableViewCell: UITableViewCell {
    
    var isBookmarkClicked: Bool = false
    var bookStoreIdx: Int = 0

    @IBOutlet weak var wholeView: UIView!
    @IBOutlet var hashTagCollection: [UIView]!
    
    @IBOutlet weak var bookStoreImageView: UIImageView!
    @IBOutlet weak var bookStoreName: UILabel!
    @IBOutlet weak var hashTagLabel01: UILabel!
    @IBOutlet weak var hashTagLabel02: UILabel!
    @IBOutlet weak var hashTagLabel03: UILabel!
    
    @IBOutlet weak var bookmarkButton: UIButton!
    
    var delegate: ButtonActionDelegate?
    var indexPath: IndexPath?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        for view in hashTagCollection{
            view.layer.cornerRadius = 5
            view.layer.borderWidth = 1
            view.layer.borderColor = UIColor.dustyOrange.cgColor
        }
        //bookStoreImageView.layer.cornerRadius = 10
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setBookStoreData(image1: String, bookStoreName: String, hashtag1: String, hashtag2:String, hashtag3:String, bookStoreIdx: Int){
        let url = URL(string: image1)
        guard let data = try? Data(contentsOf: url!) else {return}
        self.bookStoreImageView.image = UIImage(data: data)
        self.bookStoreName.text = bookStoreName
        hashTagLabel01.text = hashtag1
        hashTagLabel02.text = hashtag2
        hashTagLabel03.text = hashtag3
        
        self.bookStoreIdx = bookStoreIdx
    }
    
    @IBAction func bookmarkButtonAction(_ sender: UIButton) {
//        if isBookmarkClicked == false{
            //put data
            //reload tableview cell
        bookmarkButton.setImage(UIImage(named: "icBookmark"), for: .selected)
        deleteData(idx: self.bookStoreIdx)
        
        print("셀의 bookrmarkbuttonidnexpath: \(self.indexPath!)")
        self.delegate?.bookmarkButtonClick(at: self.indexPath!)
//            isBookmarkClicked = true
//        }
//        else{
//            bookmarkButton.setImage(UIImage(named: "icBookmarkSelected"), for: .normal)
//            isBookmarkClicked = false
//        }
    }
    
    func deleteData(idx: Int){
        InterestService.shared.putBookStoreData(bookStoreIdx: idx){ NetworkResult in
            switch NetworkResult {
            case .success(let data):
                guard let data = data as? Checked else {return print("put data error")}
                print("@@@data@@@")
                print(data)
                
                
            case .requestErr(_):
                print("Request error@@")
            case .pathErr:
                print("path error")
            case .serverErr:
                print("server error")
            case .networkFail:
                print("network error@@")
            }
        }
    }
    

}
