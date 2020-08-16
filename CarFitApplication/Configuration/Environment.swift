//
//  Environment.swift
//  CarFitApplication
//
//  Created by Muhammad Usman on 07/08/2020.
//  Copyright © 2020 usman. All rights reserved.
//

import Foundation

public enum Environment {
    // MARK: - Keys
    
    enum Keys {
        static let isLogEnabled = "LOG_ENABLED"
    }
    
    // MARK: - Plist
    
    private static let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("Plist file not found")
        }
        return dict
    }()
    
    // MARK: - Plist values
    
    static let isLogEnabled: Bool = {
        guard let isEnabled = Environment.infoDictionary[Keys.isLogEnabled] as? String else {
            return false
        }
        
        return isEnabled == "true" ? true : false
    }()
}
