import UIKit

extension UITableView {
    public static let contentSizeKeyPath = "contentSize"
    
    public func reloads() {
        DispatchQueue.main.async {
            self.reloadData()
        }
    }
}
