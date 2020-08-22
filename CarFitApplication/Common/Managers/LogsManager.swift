//
//  LogsManager.swift
//  CarFitApplication
//
//  Created by Usman on 07/08/2020.
//  Copyright © 2020 usman-pucit All rights reserved.
//

import Foundation

// MARK: - Manager for application logs

/// Enhancement can be made to print pretty JSON for API request/ response/ error etc.
final class LogsManager {
    // MARK: - Function to print logs

    static func printLog(_ value: Any) {
        if Environment.isLogEnabled {
            print(value)
        }
    }
}
