import Foundation
import UIKit
import NMapsMap

class DetailViewController: UIViewController, StoryboardBased {
    @IBOutlet weak var maskView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var commonView: CommonView!
    @IBOutlet weak var bodyView: UIView!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var testLabel: UILabel!
    @IBOutlet var bookstoreCollection: [UIButton]!
    @IBOutlet weak var reviewTableView: UITableView!
    @IBOutlet weak var tableviewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var bookStoreNameLabel: UILabel!
    @IBOutlet var bookstoreImageVIew: [UIImageView]!
    
    @IBOutlet weak var bookstoreLocation: UILabel!
    @IBOutlet weak var bookstoreTimeLabel: UILabel!
    @IBOutlet weak var bookstorePhoneNumberLabel: UILabel!
    @IBOutlet weak var bookstoreActivityLabel: UILabel!
    @IBOutlet weak var bookstroeDestriptionTextView: UITextView!
    
    @IBOutlet weak var intableviewMoreButton: UIButton!
    
    @IBOutlet var detailLinkButton: [UIButton]!
    
    
    
    @IBOutlet weak var detailNaverMapView: NMFMapView!
    var authState: NMFAuthState!
    // Constraint from the top of the CommonView to the top of the MaskView
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var scrollHeight: NSLayoutConstraint!
    
    // Height constraint for the CommonView
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    
    
    
    private var isStatusBarHidden = true {
        willSet {
            self.setNeedsStatusBarAppearanceUpdate()
        }
    }
    var getMainRecommendImageString: String = "" // nil처리 및 오류 처리 해야함
    var getGuideLabel1: String = ""
    var getGuideLabel2: String = ""
    var getNameString:String = ""
    var getLocationString: String = ""
    var getNowBookStoreIndex: Int = 1
    var detailBookStoreModel: [DetailBookStoreModel.BookData] = []
    var myDetailReviewModel: [DetailReviewModel.ReviewData] = []
    
    
   
    var eachCellHeight: [CGFloat] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reviewTableView.delegate = self
        reviewTableView.dataSource = self
        
        reviewTableView.rowHeight = UITableView.automaticDimension
        reviewTableView.estimatedRowHeight = 100
        setMainCommonView()
        //setNaverMap()
        
        for buttonIndex in 0...2 {
            bookstoreCollection[buttonIndex].settagButton()
        }
        
        
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(appMovedToBackground), name: UIApplication.willEnterForegroundNotification, object: nil)
        
        
        
        self.bookstoreCollection[1].titleLabel?.text = "asdffasff"
        
        
        //tableviewHeight.constant = 0
        
        //리뷰데이터 없을때 스크롤 height
        //scrollHeight.constant = 1830
        //리뷰데이터 있을때 스크롤 height 테이블뷰만큼 + @
        //scrollHeight.constant = @
        
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    //    override var childForStatusBarHidden: UIViewController? {
    //        let viewController = RecommendViewController()
    //        return viewController
    //    }
    
    
    
    
    
    //    override var childForStatusBarHidden: UIViewController? {
    //        let viewController = DetailViewController()
    //        return viewController
    //    }
    
    //    override open var childForStatusBarStyle: UIViewController? {
    //        return self
    //    }
    //
    //    override open var childForStatusBarHidden: UIViewController? {
    //        return self
    //    }
    
    @objc func appMovedToBackground() {
        self.setTabBarHidden(true)
        
        // self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
       // DispatchQueue.main.async {
        self.downloadDetailBookStoreModel()
        self.downloadReviewData()
       // }
        
    
//        if let frame = self.tabBarController?.tabBar.frame {
//            let factor: CGFloat = true ? 1 : -1
//            let y = frame.origin.y + (frame.size.height * factor)
//            UIView.animate(withDuration: 0.3, animations: {
//                self.tabBarController?.tabBar.frame = CGRect(x: frame.origin.x, y: y, width: frame.width, height: frame.height)
//            })
//            return
//        }
        
        
//        self.tabBarController?.tabBar.isHidden = true
//        UIView.animate(withDuration: 0.3) {
//            self.view.layoutIfNeeded()
//        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
        
        self.bookstoreImageVIew[0].setImage(from: self.detailBookStoreModel[0].image1)
        self.bookstoreImageVIew[1].setImage(from: self.detailBookStoreModel[0].image2)
        self.bookstoreImageVIew[2].setImage(from: self.detailBookStoreModel[0].image3)
        
        
        //self.bookstoreCollection[0].sizeToFit()
    }
    
    func setMainCommonView() {
        commonView.mainRecommendImageView.setImage(from: getMainRecommendImageString)
        commonView.guideLabel1.text = getGuideLabel1
        commonView.guideLabel2.text = getGuideLabel2
        commonView.bookstoreName.text = getNameString
        commonView.bookstoreAddress.text = getLocationString
    }
    
    @IBAction func touchUpMoreButton(_ sender: Any) {
        //리뷰 모아둔 곳 푸쉬
    }
    
    @IBAction func touchUpHomePageButton(_ sender: Any) {
        
        if self.detailBookStoreModel[0].homepage == "NULL" {
            showAlert(style: .alert)
            return
        }
        
        if let homeURL = URL(string: "\(self.detailBookStoreModel[0].homepage)") {
            UIApplication.shared.open(homeURL, options: [:])
        }

    }
    @IBAction func touchUpFacebookButton(_ sender: Any) {
        if self.detailBookStoreModel[0].facebook == "NULL" {
            showAlert(style: .alert)
            return
        }
        
        if let homeURL = URL(string: "\(self.detailBookStoreModel[0].facebook)") {
            UIApplication.shared.open(homeURL, options: [:])
        }
    }
    
    @IBAction func touchUpInstaButton(_ sender: Any) {
        if self.detailBookStoreModel[0].instagram == "NULL" {
            showAlert(style: .alert)
        }else {
            if let homeURL = URL(string: "\(self.detailBookStoreModel[0].instagram)") {
                UIApplication.shared.open(homeURL, options: [:])
            }
        }
    }
    //URL Button AlertPresent
    func showAlert(style: UIAlertController.Style) {
        let alert = UIAlertController(title: "알림", message: "아쉽게도 해당 페이지가 없네요!ㅠㅠ", preferredStyle: style)
        let success = UIAlertAction(title: "확인", style: .default) { (action) in
            print("확인")
        }
        
       // let cancel = UIAlertAction(title: "취소", style: .destructive, handler: nil)
        
        alert.addAction(success)
       // alert.addAction(cancel)
       
        self.present(alert, animated: true, completion: nil)
    }


    
    func downloadDetailBookStoreModel() {
        DetailBookStoreService.shared.getDetailBookStoreData(bookstoreIndex: self.getNowBookStoreIndex) { NetworkResult in
            switch NetworkResult {
            case .success(let data) :
                print("🎁 Detail BookStoreModel success 🎁 ")
                
                guard let data = data as? [DetailBookStoreModel.BookData] else {
                    print("데이터에서 리턴")
                    return
                }
                
                self.detailBookStoreModel = data
                
                
                print("어 성공 \(self.detailBookStoreModel[0].image1)")
                print("어 성공 \(self.detailBookStoreModel[0].bookstoreName)")
                
                print(Thread.isMainThread)
                
                
                self.bookStoreNameLabel.text = self.detailBookStoreModel[0].bookstoreName
                
                
                self.bookstoreLocation.text = self.detailBookStoreModel[0].location
                self.bookstorePhoneNumberLabel.text = self.detailBookStoreModel[0].tel
                self.bookstoreActivityLabel.text = self.detailBookStoreModel[0].activity
                self.bookstoreTimeLabel.text = "\(self.detailBookStoreModel[0].time)\n시간 변동 가능"
                self.bookstroeDestriptionTextView.text = self.detailBookStoreModel[0].description
                
                
                
                
                //해시태그 버튼 라벨 삽입
                

                
                self.bookstoreCollection[0].setTitle(self.detailBookStoreModel[0].hashtag1, for: .normal)
                
                print("\(self.detailBookStoreModel[0].hashtag1)")
               
                self.bookstoreCollection[1].setTitle(self.detailBookStoreModel[0].hashtag2, for: .normal)
                self.bookstoreCollection[1].titleLabel?.text = self.detailBookStoreModel[0].hashtag2
                
                self.bookstoreCollection[2].setTitle(self.detailBookStoreModel[0].hashtag3, for: .normal)
                
                //지도 통신 이동 , 함수로 빼서 데이터 없을때 분기처리 해야함
                self.setNaverMap()
                DispatchQueue.main.async {
                    
                }
                
                
                self.view.layoutIfNeeded()
                
                
            case .requestErr(_):
                print("Detail Request error")
            case .pathErr:
                print("path error")
            case .serverErr:
                print("server error")
            case .networkFail:
                print("network error")
            }
        }
    }
    
    
    
    func downloadReviewData(){
        DetailReviewService.shared.getReviewData(bookstoreIndex: 2) { NetworkResult in
            switch NetworkResult {
            case .success(let data) :
                print("🎁 recommendation review success 🎁 ")
                
//                if data as! Bool == false {
//                    //후기 없을때
//                    //self.scrollHeight.constant = 1830
//                    return
//                }
                
                
                guard let data = data as? [DetailReviewModel.ReviewData] else {
                    print("데이터에서 리턴")
                    return
                }
                
                self.myDetailReviewModel = data
                var index: Int = 0
                self.myDetailReviewModel.forEach { element in
                    let eachLabel: UILabel = {
                        let label = UILabel()
                        label.numberOfLines = 0
                        label.text = self.myDetailReviewModel[index].content
                        index += 1
                        return label
                    }()
                    
                    
                    let size = eachLabel.sizeThatFits(CGSize(width: 100, height: 100))
                    print(size.height/10)
                    self.eachCellHeight.append(320 + (size.height/10))
                }
                
                
                
                
                DispatchQueue.main.async {
                    self.reviewTableView.reloadData()
                }
                
                print(data)
                
                
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
    
    
    @IBAction func touchUpLocationButton(_ sender: Any) {
        goToNaverMap()
    }
    func setNaverMap(){
        //지도 커스텀
        let marker = NMFMarker()
        
        let bookstoreLatitude:Double = Double( self.detailBookStoreModel[0].latitude)
        let bookstoreLongitude:Double = Double(self.detailBookStoreModel[0].longitude)
        
        marker.position = NMGLatLng(lat: bookstoreLatitude, lng: bookstoreLongitude)
        let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: bookstoreLatitude, lng: bookstoreLongitude))
        
        cameraUpdate.reason = 3
        cameraUpdate.animation = .fly
        cameraUpdate.animationDuration = 2
        
        detailNaverMapView.mapType = .basic
        detailNaverMapView.minZoomLevel = 5.0
        detailNaverMapView.maxZoomLevel = 18.0
        detailNaverMapView.zoomLevel = 15.0
        detailNaverMapView.moveCamera(cameraUpdate, completion: { (isCancelled) in
            if isCancelled {
                print("카메라 이동 취소")
            } else {
                print("카메라 이동 성공")
            }
        })
        
        marker.touchHandler = { (overlay) in
            
            print("마커 클릭됨")
            self.goToNaverMap()
            
            return true
        }
        
        marker.mapView = detailNaverMapView
    }
    
    
    func goToNaverMap(){
        let appStoreURL = URL(string: "http://itunes.apple.com/app/id311867728?mt=8")!
        
        let latitude: Double = Double(self.detailBookStoreModel[0].latitude)
        let longtitude: Double = Double(self.detailBookStoreModel[0].longitude)
        
        if let detailMapURL = URL(string: "nmap://place?lat=\(latitude)&lng=\(longtitude)&name=Cozy%ea%b0%80%20%ec%b6%94%ec%b2%9c%ed%95%98%eb%8a%94%20%ec%84%9c%ec%a0%90&gamsung.Cozy=Cozy"), UIApplication.shared.canOpenURL(detailMapURL)
        { // 유효한 URL인지 검사합니다.
            if #available(iOS 10.0, *) { //iOS 10.0부터 URL를 오픈하는 방법이 변경 되었습니다.
                UIApplication.shared.open(detailMapURL, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(appStoreURL)
                
            }
            
        }
    }
    
    
    
    @IBAction func closePressed(_ sender: Any) {
        //self.scrollView.scrollToTop()
        self.setTabBarHidden(false)
        self.navigationController?.popViewController(animated: true)
        
    }
    
    func asCard(_ value: Bool) {
        if value {
            // Round the corners
            self.maskView.layer.cornerRadius = 10
        } else {
            // Round the corners
            self.maskView.layer.cornerRadius = 0
        }
    }
}


extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return eachCellHeight[indexPath.row]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myDetailReviewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reviewCell = reviewTableView.dequeueReusableCell(withIdentifier: "reviewCell", for: indexPath) as! reviewTableViewCell
        
        reviewCell.reviewNameLabel.text = myDetailReviewModel[indexPath.row].nickname
        reviewCell.reviewImageView.setImage(from: myDetailReviewModel[indexPath.row].profile)
        reviewCell.reviewWriteLabel.text = myDetailReviewModel[indexPath.row].content
        reviewCell.reviewTime.text = myDetailReviewModel[indexPath.row].createdAt
    
        
//        let backgroundView = UIView()
//        backgroundView.backgroundColor = UIColor.white
//        reviewCell.selectedBackgroundView = backgroundView
        
        
        return reviewCell
        
    }
    
    
}




extension DetailViewController: Animatable {
    var containerView: UIView? {
        return self.view
    }
    
    var childView: UIView? {
        return self.commonView
    }
    
    func presentingView(
        sizeAnimator: UIViewPropertyAnimator,
        positionAnimator: UIViewPropertyAnimator,
        fromFrame: CGRect,
        toFrame: CGRect
    ) {
        // Make the common view the same size as the initial frame
        self.heightConstraint.constant = fromFrame.height
        
        // Show the close button
        self.closeButton.alpha = 1
        
        // Make the view look like a card
        self.asCard(true)
        
        // Redraw the view to update the previous changes
        self.view.layoutIfNeeded()
        
        // Push the content of the common view down to stay within the safe area insets
        
        
        //        let safeAreaTop =
        //            UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.safeAreaInsets.top ?? .zero
        
        let safeAreaTop = self.view.window?.safeAreaInsets.top ?? .zero
        print("safeAreaTop 값: \(safeAreaTop)")
        
        self.commonView.topConstraintValue = safeAreaTop + 16
        
        // Animate the common view to a height of 500 points
        self.heightConstraint.constant = 405
        sizeAnimator.addAnimations {
            self.view.layoutIfNeeded()
        }
        
        // Animate the view to not look like a card
        positionAnimator.addAnimations {
            self.asCard(false)
        }
    }
    
    func dismissingView(
        sizeAnimator: UIViewPropertyAnimator,
        positionAnimator: UIViewPropertyAnimator,
        fromFrame: CGRect,
        toFrame: CGRect
    ) {
        // If the user has scrolled down in the content, force the common view to go to the top of the screen.
        self.topConstraint.isActive = true
        
        // If the top card is completely off screen, we move it to be JUST off screen.
        // This makes for a cleaner looking animation.
        if scrollView.contentOffset.y > commonView.frame.height {
            self.topConstraint.constant = -commonView.frame.height
            self.view.layoutIfNeeded()
            
            // Still want to animate the common view getting pinned to the top of the view
            self.topConstraint.constant = 0
        }
        
        // Common view does not need to worry about the safe area anymore. Just restore the original value.
        self.commonView.topConstraintValue = 16
        
        // Animate the height of the common view to be the same size as the TO frame.
        // Also animate hiding the close button
        self.heightConstraint.constant = toFrame.height
        sizeAnimator.addAnimations {
            self.closeButton.alpha = 0
            self.view.layoutIfNeeded()
        }
        
        // Animate the view to look like a card
        positionAnimator.addAnimations {
            self.asCard(true)
        }
    }
}



extension UIScrollView {
    
    func scrollToTop() {
        let topOffset = CGPoint(x: 0, y: -contentInset.top)
        setContentOffset(topOffset, animated: false)
    }
}



