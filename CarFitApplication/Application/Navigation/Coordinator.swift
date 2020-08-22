//
//  Coordinator.swift
//  CarFitApplication
//
//  Created by Usman on 07/08/2020.
//  Copyright © 2020 usman-pucit All rights reserved.
//

import UIKit

// MARK: - Protocol

/// Abstract functions for app navigation.
protocol Coordinator {
    var navigationController: UINavigationController { get set }
    func start()
}
