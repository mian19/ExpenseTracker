//
//  SceneDelegate.swift
//  ExpenseTracker
//
//  Created by Kyzu on 24.12.22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var coordinator: AppCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let navController = UINavigationController()
        coordinator = AppCoordinator(navigationController: navController)
        coordinator?.start()
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
    }
    
}

