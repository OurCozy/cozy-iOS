<p align="center">
  <img src="./screenshots/cozy.png" width="100" />   
</p>

<h1 align="center"> Cozy_iOS 📚 </h1>

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

## Workflow

<p align="center">
  <img src="./screenshots/workflow.png" width="1000">
</p>

<br/>

### OUR SOPT 26th iOS Project

- 개발 기간 : 2020년 6월 28일 ~ 2020년 7월 18일 

<br/>

## Library

- pod [Alamofire](https://github.com/Alamofire/Alamofire) '~> 4.8.2'
- pod [Kingfisher](https://github.com/onevcat/Kingfisher) '~> 5.0'
- pod [Cosmos](https://github.com/evgenyneu/Cosmos) '~> 22.1'
- pod [NMapsMap]()

<br/>

## Screenshots 📱

### Splash

<img src="./screenshots/splash.png" width="300">

<br/>

### Login

<img src="./screenshots/login.png" width="300"> <img src="./screenshots/facebook.png" width="300"> <img src="./screenshots/naver.png" width="300"> <img src="./screenshots/emaillogin.png" width="300">

<br/>

### Main

<img src="./screenshots/main.png" width="300"> 

> main animation

<img src="./screenshots/main-anim.gif" width="250"> <img src="./screenshots/main-anim2.gif" width="250"> <img src="./screenshots/main-anim3.gif" width="250">

<br/>

### Map

<img src="./screenshots/map.png" width="300"> <img src="./screenshots/map-select.png" width="300">

> map animation

<img src="./screenshots/map-anim.gif" width="250">

<br/>

### Search

<img src="./screenshots/search.png" width="300">

> 키워드 검색, 텍스트 검색

<img src="./screenshots/search-keyword-anim.gif" width="250"> <img src="./screenshots/search-anim2.gif" width="250">

<br/>

### Bookmark

<img src="./screenshots/bookmark.png" width="300">  <img src="./screenshots/bookmark-anim.gif" width="250">

<br/>

### My page

<img src="./screenshots/mypage.png" width="300"> <img src="./screenshots/mypage-comment.png" width="300">  <img src="./screenshots/mypage-event.png" width="300">  <img src="./screenshots/mypage-notice.png" width="300"> 

<img src="./screenshots/mypage-profile-anim.gif" width="250">

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

## 📱 Progress of Cozy

|                             기능                             |                   구현                    |
| :----------------------------------------------------------: | :---------------------------------------: |
|               메인 추천뷰 - 고정 가이드셀 구현               |     [📘인준](https://github.com/iJoom)     |
|    메인 추천뷰 - 펼쳐지면서 스크롤뷰 전환 애니메이션 구현    |     [📘인준](https://github.com/iJoom)     |
|       메인 DetailView - 애니메이션 후 디테일뷰로 전환        |     [📘인준](https://github.com/iJoom)     |
| 메인 추천 및 DetailView - 탭바 밑으로 내려가고 위로 올라가는 애니메이션 구현 |     [📘인준](https://github.com/iJoom)     |
|           메인 추천뷰 - 서버APi 이용한 통신 붙이기           |                     -                     |
|         메인 DetailView - 지도APi 구현 및 링크 연결          |                     -                     |
| MapView - 지역에 따른 서점 리스트 조회 | [📙은지](https://github.com/ChoiEunji0114) |
| MapView - custom navigation bar | [📙은지](https://github.com/ChoiEunji0114) |
| MapView - 지역 선택 pop up view | [📙은지](https://github.com/ChoiEunji0114) |
| MapView - 서점 리스트 서버 통신 | [📙은지](https://github.com/ChoiEunji0114) |
| MapDetailView - APPLE지도 이용하여 위치 표시 | [📙은지](https://github.com/ChoiEunji0114) |
| MapDetailView - 경로 버튼 클릭시 네이버 맵 이동 | [📙은지](https://github.com/ChoiEunji0114) |
| MapDetailView - 서점 상세 정보 서버 통신 | [📙은지](https://github.com/ChoiEunji0114) |
| Review - 별점 | [📙은지](https://github.com/ChoiEunji0114) |
| SearchView - View 그리기 및 코드 연결 | [📙은지](https://github.com/ChoiEunji0114) |
|           Server 통신을 이용한 나만의 북마크 기능            |                     -                     |
|     BookMarkView - 테이블뷰를 이용한 커스텀 View 그리기      |  [📗재욱](https://github.com/didwodnr123)  |
|             BookMarkView - 서점에 관한 Tag 구현              |  [📗재욱](https://github.com/didwodnr123)  |
|    BookMarkView - 북마크한 책이 없을때를 확인해 View 구성    |                     -                     |
|               MyPage - 뷰 그리기 및 코드 연결                |   [📒지영](https://github.com/yangg0228)   |
|               MyPage - 기기에 맞는 AutoLayout                |                     -                     |
|                      MyPage - 공지사항                       |                     -                     |

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
    * Cell 같은 경우 - Cell로 View의 메인을 구현하는 경우, 즉 뷰컨에 더욱 가까운 역할을 하면 그 기능안에 Cell을 넣어도 됨
  * 복잡한 View 구현시 기능 안에서도 폴더를 나눠 View와 코드를 분담시킴

<br/>

## 👩‍👩‍👦‍👦 Contributor

- [황인준](https://github.com/iJoom)
- [최은지](https://github.com/ChoiEunji0114)
- [양재욱](https://github.com/didwodnr123)
- [양지영](https://github.com/yangg0228)
