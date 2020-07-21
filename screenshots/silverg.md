# 지역별 서점 조회

***

* 지역 선택 view 를 dismiss 할 때마다 서버 통신하기 -> `NSNotification` 으로 해결 ❗️

```swift
// notification 등록
extension NSNotification.Name {
    static let dismissSlideView = NSNotification.Name("dismissSlideView")
}
```

```swift
  // dismiss 시켜줄 때마다 button tag 값을 전송 (지역 index값)
  self.dismiss(animated: true, completion: {
       NotificationCenter.default.post(name: .dismissSlideView, object: sender.tag)
  })
```

```swift
    // observer 등록
    private func addObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(downloadmap(_:)), name: .dismissSlideView, object: nil)
    }
```

```swift
   // 원하는 동작 작성
    @objc func downloadmap(_ notification: NSNotification) {
        let getIdx = notification.object as! Int
        self.mapIdx = getIdx 
        downloadMapData(mapIndex: getIdx)
        self.backView.isHidden = true
    }
```

