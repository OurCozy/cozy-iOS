import UIKit

// image const
private struct Const {
    /// Image height/width for Large NavBar state
    static let ImageSizeForLargeState: CGFloat = 40
    /// Margin from right anchor of safe area to right anchor of Image
    static let ImageRightMargin: CGFloat = 16
    /// Margin from bottom anchor of NavBar to bottom anchor of Image for Large NavBar state
    static let ImageBottomMarginForLargeState: CGFloat = 12
    /// Margin from bottom anchor of NavBar to bottom anchor of Image for Small NavBar state
    static let ImageBottomMarginForSmallState: CGFloat = 6
    /// Image height/width for Small NavBar state
    static let ImageSizeForSmallState: CGFloat = 32
    /// Height of NavBar for Small state. Usually it's just 44
    static let NavBarHeightSmallState: CGFloat = 44
    /// Height of NavBar for Large state. Usually it's just 96.5 but if you have a custom font for the title, please make sure to edit this value since it changes the height for Large state of NavBar
    static let NavBarHeightLargeState: CGFloat = 96.5
}


class InterestViewController: UIViewController {
    
    private let searchImage = UIImageView(image: UIImage(named: "icSearch")) // search image
    
    var bookStoreList: [BookStoreData] = []
    var nickName: String = ""
    let navigationString: String = "님의 콕!"
    //    let data01 = BookStore(bookStoreImageName: "74", bookStoreName: "재욱이의 책방", hashTag01: "멋짐", hashTag02: "완전 멋짐", hashTag03: "개멋짐")
    //    let data02 = BookStore(bookStoreImageName: "91", bookStoreName: "지윤이의 책방", hashTag01: "안 멋짐", hashTag02: "완전 안 멋짐", hashTag03: "그냥 안 멋짐")
    //    let data03 = BookStore(bookStoreImageName: "74", bookStoreName: "재욱이의 책방", hashTag01: "멋짐", hashTag02: "완전 멋짐", hashTag03: "개멋짐")
    
    @IBOutlet weak var tableView: UITableView! // table view
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.tabBarController?.tabBarItem.image = UIImage(named: "icTabBookmark")
    
        tableView.delegate = self
        tableView.dataSource = self
        setBookStoreData()
        
        if #available(iOS 11.0, *){
            self.navigationController?.navigationBar.prefersLargeTitles = true
            self.navigationController?.navigationBar.addSubview(searchImage)
            
            
            searchImage.layer.cornerRadius = Const.ImageSizeForLargeState / 2
            searchImage.clipsToBounds = true
            searchImage.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                searchImage.rightAnchor.constraint(equalTo: (self.navigationController?.navigationBar.rightAnchor)!, constant: -Const.ImageRightMargin),
                searchImage.bottomAnchor.constraint(equalTo: (self.navigationController?.navigationBar.bottomAnchor)!, constant: -Const.ImageBottomMarginForLargeState),
                searchImage.heightAnchor.constraint(equalToConstant: Const.ImageSizeForLargeState),
                searchImage.widthAnchor.constraint(equalTo: searchImage.heightAnchor)
            ])
            
            
            //            self.navigationController?.navigationBar.backgroundColor
            //            let navBarHeight = UIApplication.shared.statusBarFrame.size.height +
            //            (navigationController?.navigationBar.frame.height ?? 0.0)
            //            print(navBarHeight)
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        if let index = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: index, animated: true)
        }
    }
    
    func setBookStoreData(){
        InterestService.shared.getBookStoreData(){ NetworkResult in
            switch NetworkResult {
                case .success(let data):
                    guard let data = data as? [BookStoreData] else {return print("error")}
                    print("@@@@@@data@@@@@@")
                    print(data)
                    for data in data{
                        if data.bookstoreName == "" && data.nickname != "" {
                            self.nickName = data.nickname
                        } else {
                            self.bookStoreList.append(BookStoreData(bookstoreIdx: data.bookstoreIdx, bookstoreName: data.bookstoreName, profile: data.profile, hashtag1: data.hashtag1, hashtag2: data.hashtag2, hashtag3: data.hashtag3, nickname: data.nickname))
                            self.nickName = self.bookStoreList[0].nickname
                        }
                    }
                    self.navigationItem.title = self.nickName + self.navigationString
                    self.tableView.reloadData()

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
    
}

extension InterestViewController: UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 287
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if bookStoreList.count == 0 {
            tableView.setEmptyView(title: self.nickName + "만의 책박을 콕! 해볼까요?", message: "책방이 비어있습니다!")
        }
        else {
            tableView.restore()
        }
        
        return bookStoreList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell2") as! BookStoreTableViewCell
        cell.wholeView.setViewShadow()
        
        cell.setBookStoreData(profile: bookStoreList[indexPath.row].profile, bookStoreName: bookStoreList[indexPath.row].bookstoreName, hashtag1: bookStoreList[indexPath.row].hashtag1, hashtag2: bookStoreList[indexPath.row].hashtag2, hashtag3: bookStoreList[indexPath.row].hashtag3)
        
        return cell
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if tableView.contentOffset.y == 0 {
            // 가장 상단에 있을 때
            // button.isHidden = false
        }
        else {
            // 가장 상단이 아닐 때
        }
    }
}

extension UITableView {
    func setEmptyView(title: String, message: String) {
        let emptyView = UIView(frame: CGRect(x: self.center.x, y: self.center.y, width: self.bounds.size.width, height: self.bounds.size.height))
        let titleLabel = UILabel()
        let messageLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = UIColor.black
        titleLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
        messageLabel.textColor = UIColor.lightGray
        messageLabel.font = UIFont(name: "HelveticaNeue-Regular", size: 17)
        emptyView.addSubview(titleLabel)
        emptyView.addSubview(messageLabel)
        titleLabel.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
        messageLabel.leftAnchor.constraint(equalTo: emptyView.leftAnchor, constant: 20).isActive = true
        messageLabel.rightAnchor.constraint(equalTo: emptyView.rightAnchor, constant: -20).isActive = true
        titleLabel.text = title
        messageLabel.text = message
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        // The only tricky part is here:
        self.backgroundView = emptyView
        self.separatorStyle = .none
    }
    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}
