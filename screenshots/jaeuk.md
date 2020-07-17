# 재욱이의 리드미

❗️네이게이션 바 커스텀이 쉽지 않았지만 가장 먼저 뷰를 그릴 때 LargeTitleNavigationBar 삽입을 했다.

✅ Large Title NavigationBar Custom

```swift
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
        }
```



❗️테이블뷰 셀 그림자 삽입

✅ TabelView Delegate

```swift
cell.wholeView.setViewShadow()
```

📌 테이블 뷰 DataSource에서 **setViewShadow()** 함수로 셀에 그림자를 삽입할 수 있었다.



❗️세미나때 배운 post 통신을 응용하여 get 통신을 구현하였지만 

❗️addBookStoreData()를 viewDidLoad() 함수에서 호출했더니 시뮬레이터를 계속 새로 켜야 새로운 데이터가 삽입되는 문제가 발생했다.

✅ VIewWillAppear

```swift
override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addBookStoreData()
    }
```

📌 viewWillAppear function에서 **addBookStoreData()** 를 호출해줘야 동적으로 테이블뷰에 데이터가 반영된다.



❗️북마크 해제할 때, 데이터가 이상하게 전달되는 오류를 발견했다.

- 해당 오류는 데이터가 셀에 삽입되기 전 bookStoreList에 저장되는데 리스트가 갱신이 안되서 발생했다.

```swift
self.bookStoreList.removeAll()
```

📌 list를 **removeAll()** 메소드로 초기화시켜줌으로써 제대로된 데이터를 셀에 삽입할 수 있었다.



❗️북마크된 책방이 없을때는 TextField PlaceHolder같은 뷰를 띄워야 하는데 그냥 아무것도 나오지 않았다.

✅ Extension UITableView

```swift
extension UITableView {
    func setEmptyView(title: String, message: String) {
        let emptyView = UIView(frame: CGRect(x: self.center.x, y: self.center.y, width: self.bounds.size.width, height: self.bounds.size.height))
        let titleLabel = UILabel()
        let messageLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.textColor = UIColor.black
        titleLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
        messageLabel.textColor = UIColor.gray
        messageLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 17)
        
        emptyView.addSubview(titleLabel)
        emptyView.addSubview(messageLabel)
        emptyView.backgroundColor = UIColor.white
        
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
```

📌 처음으로 **view를 코드로** 그려보았다.



✅ Tableview Delgegate, DataSource

```swift
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if bookStoreList.count == 0 {
            tableView.setEmptyView(title: "", message: "책방이 비어있습니다!")
        }
        else {
            tableView.restore()
        }
        
        return bookStoreList.count
    }
```

📌 bookStoreList.count == 0 일때 EmptyView()를 호출해서 뷰를 바꿔주었다.



❗️북마크 버튼을 눌렀을 때, **indexPath.row**를 사라지게 하는 애니메이션을 만들어야 하는데, 버튼 액션에서 put 통신은 되지만 **셀이 사라지지 않았다**.

### Cell

```swift
protocol ButtonActionDelegate {
    func bookmarkButtonClick(at indexPath: IndexPath)
}
```

```swift
var delegate: ButtonActionDelegate?
    var indexPath: IndexPath?
```

```swift
self.delegate?.bookmarkButtonClick(at: self.indexPath!)
```

### ViewController

```swift
extension InterestViewController: ButtonActionDelegate {
    func bookmarkButtonClick(at indexPath: IndexPath) {
        print(indexPath)
        bookStoreList.remove(at: indexPath.row)
        print(indexPath)
        
        self.tableView.deleteRows(at: [indexPath], with: .right)
        
        for index in indexPath.row..<bookStoreList.count {
            guard let eachCell = tableView.cellForRow(at: indexPath) as? BookStoreTableViewCell else { return print("error") }
            eachCell.indexPath = IndexPath(row: index, section: 0)
        }
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }

        print(indexPath)
    }
}
```

📌 **ButtonActionDelegate**를 사용해서 테이블뷰 셀을 지워줄 수 있었다.

