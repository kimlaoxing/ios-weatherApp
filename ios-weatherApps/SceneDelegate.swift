//  Created by Kevin Maulana Fauzan on 05/09/23.

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        let root = MainViewRouter().makeHomeTab()
        
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = root
            self.window = window
            window.makeKeyAndVisible()
        }
    }
    
    

}
