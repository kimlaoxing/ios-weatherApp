import UIKit

extension NSLayoutConstraint {
    public func activated() {
        NSLayoutConstraint.activate([self])
    }
}

