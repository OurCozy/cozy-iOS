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
    
    @IBOutlet weak var tableView: UITableView! // table view
    
    var bookStoreList: [BookStore] = []
    let data01 = BookStore(bookStoreImageName: "74", bookStoreName: "재욱이의 책방", hashTag01: "멋짐", hashTag02: "완전 멋짐", hashTag03: "개멋짐")
    let data02 = BookStore(bookStoreImageName: "91", bookStoreName: "지윤이의 책방", hashTag01: "안 멋짐", hashTag02: "완전 안 멋짐", hashTag03: "그냥 안 멋짐")
    let data03 = BookStore(bookStoreImageName: "74", bookStoreName: "재욱이의 책방", hashTag01: "멋짐", hashTag02: "완전 멋짐", hashTag03: "개멋짐")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        //sample data
        bookStoreList = [data01, data02, data03]
        
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
    
}

extension InterestViewController: UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            
        return 287
        
    }
    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 2
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return bookStoreList.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if indexPath.section == 0 {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "cell1") as! UserNameTableViewCell
//            cell.userName.text = "양재욱"
//            return cell
//        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell2") as! BookStoreTableViewCell
            cell.wholeView.setViewShadow()
            
            cell.setBookStoreData(bookStoreImageName: bookStoreList[indexPath.row].bookStoreImageName, bookStoreName: bookStoreList[indexPath.row].bookStoreName, hashTag01: bookStoreList[indexPath.row].hashTag01, hashTag02: bookStoreList[indexPath.row].hashTag02, hashTag03: bookStoreList[indexPath.row].hashTag03)
            
            return cell
        //}
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
