# 지영이의 리드미

📍컬렉션 뷰 셀에 통신을 받아오는데 어려움이 있었다.

🍎 addProfileData Function

```swift
    func addProfileData(){
        ProfileService.shared.getProfileData(){ NetworkResult in
            switch NetworkResult {
            case .success(let data):
                guard let data = data as? [UserProfile] else {return print("error")}
                self.setProfileData(profile: data[0].profile, userNickname: data[0].nickname, userEmail: data[0].email)
            
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
```

🍎 Collection View Data Source

```swift
extension MyPageViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let lastBookstoreCell =                           collectionView.dequeueReusableCell(withReuseIdentifier:LastBookstoreCell.identifier, for:indexPath) as? LastBookstoreCell else {return UICollectionViewCell() }
    
    lastBookstoreCell.bookstoreImageView.setImage(from: self.recentList[indexPath.row].image1)
    lastBookstoreCell.nameLabel.text = self.recentList[indexPath.row].bookstoreName
     
    return lastBookstoreCell
}
```


📌 해결완료

