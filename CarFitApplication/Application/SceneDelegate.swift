//
//  SceneDelegate.swift
//  CarFitApplication
//
//  Created by Usman on 07/08/2020.
//  Copyright © 2020 usman-pucit All rights reserved.
//

import UIKit

// MARK: - Class

/// Delegate class to manage scenes life cycle events.
class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    // MARK: - Properties

    var window: UIWindow?
    var coordinator: AppCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let window = window else { return }

        let navController = UINavigationController()
        navController.isNavigationBarHidden = true

        // Setting up application navigation
        coordinator = AppCoordinator(navigationController: navController)
        coordinator?.start()

        window.rootViewController = navController
        window.makeKeyAndVisible()
    }
}
