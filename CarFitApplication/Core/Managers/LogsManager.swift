//
//  LogsManager.swift
//  CarFitApplication
//
//  Created by Muhammad Usman on 07/08/2020.
//  Copyright © 2020 usman. All rights reserved.
//

import Foundation

// MARK: - Class to handler application logs 

/// Enhancement can be made to print pretty JSON for API request/ response/ error etc.
struct LogsManager {
    

    // MARK: - Function to print logs with configuration settings
    
    static func printLog(_ value: Any) {
        if Environment.isLogEnabled {
            print(value)
        }
    }
}
