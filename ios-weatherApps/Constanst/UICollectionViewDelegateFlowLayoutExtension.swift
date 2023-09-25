import UIKit

extension UICollectionViewDelegateFlowLayout {
     func UICollectionViewFiveItemPerWidth() -> CGSize {
        let availableWidth = ScreenSize.width / 5
        let widthPerItem = (availableWidth)
        let heightPerItem = widthPerItem
        return CGSize(width: widthPerItem, height: heightPerItem)
    }

}
