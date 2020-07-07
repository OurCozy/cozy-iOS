<h1 align="center"> Cozy_iOS 📗 </h1>

<p align="center">
  <img src="https://img.shields.io/badge/SOPT-blue" />
  <img src="https://img.shields.io/badge/cozy-green" />
  <img src="https://img.shields.io/badge/swift-5-orange" />
  <img src="https://img.shields.io/badge/Xcode-11.5-blue" />
  <img src="https://img.shields.io/badge/cocoapods-1.9.3-pink" />   
</p>

<p align="center">
  바쁜 도심 속 휴식처, 공간과 경험을 파는 세상의 모든 독립서점 🌱
</p>

<br/>

## ✌️ Coding Convention
- 변수 , 함수명 low camel case 사용

```swift
var isSelected: Bool 
```

```swift
func touchUpButton () {
  //code
}
```

- 변수값 숫자로 그냥 사용하지 않고, cellWidth = 400 처럼 사용 !

```swift
extension RecommendViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = CGFloat(327)
        let cellHeight = CGFloat(405)
      
        return CGSize(width: cellWidth, height: cellHeight)
    }
}
```

- Struct, Class Upper camel case 사용
- 메소드 동사 형태로, 축약어 금지 ex) tUpBtn(🙅🏻  🙅🏻‍♀️) touchUpMainButton( 🙆🏻 🙆🏻‍♂️)

```swift
class CustomExpandableCollectionViewCell: UICollectionViewCell {
  // 다음과 같이 CustomCell을 만들때도 컬렉션뷰의 셀인 것을 명시, 어떤 기능에 쓰여지는 셀인지 명시
}
```

- 강제 옵셔널 금지
- 각자 분담한 스토리보드 외에 건들기 금지
- 커밋시 반드시 서로에게 알릴것
- 남이봐도 좋은 코드에 대해 계속 생각해보기 (리팩토링 시간을 가져보게 노력)

<br/>

## 📁 Foldering

<p align="center">
  <img src="https://user-images.githubusercontent.com/55793344/86769419-1b0bcf00-c08a-11ea-8d4b-eb674b04a543.png" width="300"/>
</p>

* Resources
  * Xib, Storyboard, Assets 등 리소스 관련

* Sources
  * 크게는 코드의 기능에 따라 그리고 ViewUi로 분류
  * Protocols, Cell , Extension , Viewcontroller(뷰컨 안에 세분화된 기능으로 분류)
  * 복잡한 View 구현시 기능 안에서도 폴더를 나눠 View와 코드를 분담시킴

<br/>

## 👩‍👩‍👦‍👦 Contributor

- [황인준](https://github.com/iJoom)
- [최은지](https://github.com/ChoiEunji0114)
- [양재욱](https://github.com/didwodnr123)
- [양지영](https://github.com/yangg0228)
