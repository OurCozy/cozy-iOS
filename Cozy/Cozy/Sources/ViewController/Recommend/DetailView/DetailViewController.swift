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
    
    
    
    @IBOutlet weak var detailNaverMapView: NMFMapView!
    var authState: NMFAuthState!
    // Constraint from the top of the CommonView to the top of the MaskView
    @IBOutlet weak var topConstraint: NSLayoutConstraint!

    // Height constraint for the CommonView
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!

    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        
        
        setNaverMap()
        
        for buttonIndex in 0...2 {
            bookstoreCollection[buttonIndex].settagButton()
        }
        
        print("viewDidLoad() 호출")
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(appMovedToBackground), name: UIApplication.willEnterForegroundNotification, object: nil)
        
        
        
    }
    
    @objc func appMovedToBackground() {
        self.setTabBarHidden(true)
       // self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("viewWillAppear() 호출")
        
//        if self.tabBarController?.tabBar.isHidden == true {
//           // self.tabBarController?.tabBar.isHidden = true
//             self.setTabBarHidden(false)
//        }
     //   self.setTabBarHidden(false)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    @IBAction func touchUpLocationButton(_ sender: Any) {
        goToNaverMap()
    }
    func setNaverMap(){
        //지도 커스텀
        let marker = NMFMarker()
        marker.position = NMGLatLng(lat: 37.556693, lng: 126.929313)
        let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: 37.556693, lng: 126.929313))
        
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
                   if let detailMapURL = URL(string: "nmap://place?lat=37.556693&lng=126.929313&name=Cozy%ea%b0%80%20%ec%b6%94%ec%b2%9c%ed%95%98%eb%8a%94%20%ec%84%9c%ec%a0%90&gamsung.Cozy=Cozy"), UIApplication.shared.canOpenURL(detailMapURL)
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
