//
//  AppCoordinator.swift
//  CarFitApplication
//
//  Created by Usman on 07/08/2020.
//  Copyright © 2020 usman-pucit All rights reserved.
//

import UIKit

// MARK: - Class

/// Class to manage application navigation.

class AppCoordinator: Coordinator {
    // MARK: - Properties

    var navigationController: UINavigationController

    // MARK: - Initializer

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    // MARK: - Start coordination

    func start() {
        let vc = HomeViewController.instantiate(fromAppStoryboard: .Main)
        navigationController.pushViewController(vc, animated: false)
    }
}
