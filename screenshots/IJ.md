# 앱스토어 애니메이션 라이브러리 없이 적용하기

***

* 비슷한 애니메이션 라이브러리를 사용할까 생각 했지만 작동원리와 구조를 더 알고 싶어서 도전
* 맨 처음 구조부터 생각을 하고 테스트를 먼저해봄
  * CollectionView를 Vertical Scroll로 만들고 Cell 선택되었을때, 셀이 펼쳐지는 구조로 생각
  * 셀을 눌렀을때 애니메이션과, 스테이터스바 히든 등 아이폰 화면에 꽉차게 구현 완료
  * **그러나!** DetailView는 긴 스크롤이 필요해서 이러한 구조로 구현시 불가능

***

* 구글링 및 다른 코드를 참조
* 헤더뷰와 바디뷰로(설명하기 편하게) xib를 나누고, 셀을 눌렀을때 헤더뷰가 올라가면서 바디뷰를 애니메이션 적으로 바꿔치기 해주는 구조로 구현
* 네비게이션 컨트롤러의 push 애니메이션을 커스텀해서 적용, 이 부분은 자유

***

```swift
extension RecommendViewController: Animatable {
    var containerView: UIView? {
        return self.recommendCollectionView
    }
    
    var childView: UIView? {
        return self.selectedCell
    }
}
```

***

이런식으로 컨테이너뷰가 헤더뷰 , childView는 스크롤될 다음 메인뷰컨을 의미 합니다.

<img width="359" alt="스크린샷 2020-07-17 오후 7 31 11" src="https://user-images.githubusercontent.com/55793344/87777254-23bb8c80-c864-11ea-9d2b-4b3ba6adf75e.png">

* 다음과 같이 셀의 보여지는 뷰가, 초록색뷰(컨테이너뷰)가 보여지고 애니메이션으로 스크롤되는 부분이 보여지는 형식

* DetailView는 ViewController로 만들어짐, 애니메이션은 extension을 이용해 다음과 같이 구현

```swift
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
        self.heightConstraint.constant = fromFrame.height
        
        // Show the close button
        self.closeButton.alpha = 1
        self.asCard(true)
        self.view.layoutIfNeeded()
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
        self.topConstraint.isActive = true
        if scrollView.contentOffset.y > commonView.frame.height {
            self.topConstraint.constant = -commonView.frame.height
            self.view.layoutIfNeeded()
            
            // Still want to animate the common view getting pinned to the top of the view
            self.topConstraint.constant = 0
        }
        self.commonView.topConstraintValue = 16
        self.heightConstraint.constant = toFrame.height
        sizeAnimator.addAnimations {
            self.closeButton.alpha = 0
            self.view.layoutIfNeeded()
        }
        
        // 카드처럼 보여지는 애니메이션
        positionAnimator.addAnimations {
            self.asCard(true)
        }
    }
}
```

* 헤더뷰의 탑헤이트를 이용해 조절
* 리커멘드뷰에서 상단, 중단, 하단 셀을 선택시 각기 다른 헤더의 애니메이션이 적용

***

```swift
protocol Animatable {
    var containerView: UIView? { get }
    var childView: UIView? { get }

    func presentingView(
        sizeAnimator: UIViewPropertyAnimator,
        positionAnimator: UIViewPropertyAnimator,
        fromFrame: CGRect,
        toFrame: CGRect
    )

    func dismissingView(
        sizeAnimator: UIViewPropertyAnimator,
        positionAnimator: UIViewPropertyAnimator,
        fromFrame: CGRect,
        toFrame: CGRect
    )
}

/// Default implementations
extension Animatable {
    func presentingView(
        sizeAnimator: UIViewPropertyAnimator,
        positionAnimator: UIViewPropertyAnimator,
        fromFrame: CGRect,
        toFrame: CGRect
    ) {}

    func dismissingView(
        sizeAnimator: UIViewPropertyAnimator,
        positionAnimator: UIViewPropertyAnimator,
        fromFrame: CGRect,
        toFrame: CGRect
    ) {}
}
```

* Animatable 프로토콜을 이용해 애니메이팅 구현

***

* 헤더뷰와 스크롤뷰가 화면 전체와 꽉차게 되는 애니메이션은 코드 참조 및 공부로 구현
* extension을 이용해 CustomTransitionAnimation 구현
* NavigationContorller의 Push가 해당 커스텀 애니메이션으로 구현 되게 구현

```swift
extension CustomTransitionAnimation {
    // Custom push animations
    internal func presentTransition(_ transitionContext: UIViewControllerContextTransitioning) {
        print("presentTransition 진입")
        let container = transitionContext.containerView

        // ===========================================================
        // Step 1: Get the views we are animating
        // ===========================================================

        // Views we are animating FROM
        guard
            let fromVC = transitionContext.viewController(forKey: .from) as? Animatable,
            let fromContainer = fromVC.containerView,
            let fromChild = fromVC.childView
        else {
            return
        }

        // Views we are animating TO
        guard
            let toVC = transitionContext.viewController(forKey: .to) as? Animatable,
            let toView = transitionContext.view(forKey: .to)
        else {
            return
        }
        
        

        // Preserve the original frame of the toView
        let originalFrame = toView.frame

        container.addSubview(toView)

        // ===========================================================
        // Step 2: Determine start and end points for animation
        // ===========================================================

        // Get the coordinates of the view inside the container
        let originFrame = CGRect(
            origin: fromContainer.convert(fromChild.frame.origin, to: container),
            size: fromChild.frame.size
        )
        let destinationFrame = toView.frame

        toView.frame = originFrame
        toView.layoutIfNeeded()

        fromChild.isHidden = true

        // ===========================================================
        // Step 3: Perform the animation
        // ===========================================================

        let yDiff = destinationFrame.origin.y - originFrame.origin.y
        let xDiff = destinationFrame.origin.x - originFrame.origin.x

        // For the duration of the animation, we are moving the frame. Therefore we have a separate animator
        // to just control the Y positioning of the views. We will also use this animator to determine when
        // all of our animations are done.

        // Animate the card's vertical position
        let positionAnimator = UIViewPropertyAnimator(duration: self.positioningDuration - 0.1, dampingRatio: 0.7) //base dampingRatio 0.7
        positionAnimator.addAnimations {
            // Move the view in the Y direction
            toView.transform = CGAffineTransform(translationX: 0, y: yDiff)
        }

        // Animate the card's size
        let sizeAnimator = UIViewPropertyAnimator(duration: self.resizingDuration - 0.1, curve: .easeInOut)
        sizeAnimator.addAnimations {
            // Animate the size of the Card View
            toView.frame.size = destinationFrame.size
            toView.layoutIfNeeded()

            // Move the view in the X direction. We concatenate here because we do not want to overwrite our
            // previous transformation
            toView.transform = toView.transform.concatenating(CGAffineTransform(translationX: xDiff, y: 0))
        }

        // Call the animation delegate
        toVC.presentingView(
            sizeAnimator: sizeAnimator,
            positionAnimator: positionAnimator,
            fromFrame: originFrame,
            toFrame: destinationFrame
        )

        // Animation completion.
        let completionHandler: (UIViewAnimatingPosition) -> Void = { _ in
            toView.transform = .identity
            toView.frame = originalFrame

            toView.layoutIfNeeded()

            fromChild.isHidden = false

            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }

        // Put the completion handler on the longest lasting animator
        if (self.positioningDuration > self.resizingDuration) {
            positionAnimator.addCompletion(completionHandler)
        } else {
            sizeAnimator.addCompletion(completionHandler)
        }

        // Kick off the two animations
        positionAnimator.startAnimation()
        sizeAnimator.startAnimation()
    }
```

***

# 네이버지도APi 이용한 지도앱 이동, 그에 따르는 문제 해결

***

```swift
        let marker = NMFMarker()
        
        let bookstoreLatitude:Double = Double( self.detailBookStoreModel[0].latitude)
        let bookstoreLongitude:Double = Double(self.detailBookStoreModel[0].longitude)
        
        marker.position = NMGLatLng(lat: bookstoreLatitude, lng: bookstoreLongitude)
```

* 다음과 같은 코드로 마커를 지도에 표현 가능
* **그러나** 실제 앱에서 지도를 보면, 보이지 않음...Why? 지도의 카메라 이동 또한 마커로 이동시켜야함

```swift
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
        
        
        marker.mapView = detailNaverMapView
```

* 다음과 같이 지도의 확대 레벨 및 카메라를 이동 시켜주면 원하는 곳의 위도 경도값의 마커를 지도뷰로 표현 가능

* 또한 다음의 마커 터치 이벤트를 이용해 네이버지도 앱으로 이동가능

```swift
        marker.touchHandler = { (overlay) in
            
            print("마커 클릭됨")
            self.goToNaverMap()
            
            return true
        }
```

* 앱의 스키마URL을 이용해 해당 앱으로 이동 가능, 네이버 지도 앱이 없을시 앱스토어 네이버지도로 이동

```swift
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
```

***

* 실제 아이폰에서 작동시 구현이 잘되어짐
* ***네이버지도 앱을 갔다가 다시, Cozy앱으로 돌아올시 탭바가 다시 생성되는 문제 발생***

```swift
 let notificationCenter = NotificationCenter.default
notificationCenter.addObserver(self, selector: #selector(appMovedToBackground), name: UIApplication.willEnterForegroundNotification, object: nil)
```

* 앱딜리게이트 백그라운드 호출시 다시 한번 탭바를 사라지게 해주어 문제 해결
* 다른 앱을 갔다가 다시 돌아올시, 호출문제로 인해 탭바 히든이 풀리는 것으로 추정

***

## TableView의 유동적인 Label의 헤이트에 따라 셀의 크기가 각기 다르게 생성

```swift
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
```

* 임의의 레이블에 텍스트를 넣어서, 헤이트 사이즈를 대략적으로 구함
* 헤이트값이 너무 크게 잡혀서, /10으로 비율값을 조절시 원하는 정도의 사이즈 구현 가능
* 셀의 오토레이아웃도 레이브이 가변적으로 변할 수 있게 잡아두어야함

```swift
    tableView.rowHeight = UITableView.automaticDimension
    tableView.estimatedRowHeight = 100
```

* 오토메틱셀을 이용해 헤이트 값을 조정하는 방식도 있음

***

# 탭바히든 애니메이션이 안먹히는 버그 발생

* 애니메이션과, 호출등을 바꿔 보았으나 원인이 딱히 잡히지 않음
* 11pro, xs, promax 계열은 잘되나, 홈버튼이 있는 아이폰8, SE2, 8+에서는 프레임의 헤이트 위드등 계산이 맞게 되나, 애니메이션과 isHidden 또한 에러 발생

* 기기별로 분기처리로 해결, 프로젝트가 끝난 후 조금 더 원인을 분석!

```swift
switch deviceHeight {
        case 667.0: //iphone 6, 6s, 7, 8 => 4.7 inch
            self.tabBarController?.tabBar.isHidden = false
        case 812.0: //iphone X, XS => 5.8 inch
            self.setTabBarHidden(false)
        default:
            self.setTabBarHidden(false)
        }
```

