//
//  ApplicationRoot.swift
//  CarFitApplication
//
//  Created by Muhammad Usman on 07/08/2020.
//  Copyright © 2020 usman. All rights reserved.
//

import UIKit

// MARK: - Extension to set custom applicaton root at any level.

extension SceneDelegate: ApplicationRoot {
    
    // MARK: Function to setup application root
    
    func setupRoot(with window: UIWindow) {
        window.makeKeyAndVisible()
        let vc = HomeViewController.instantiate(fromAppStoryboard: .Main)
        window.rootViewController = vc 
    }
}
