//
//  String.swift
//  CarFitApplication
//
//  Created by Muhammad Usman on 10/08/2020.
//  Copyright © 2020 usman. All rights reserved.
//

import Foundation

// MARK: - Extension

extension String {
    // MARK: - Function local time to UTC
    
    func localToUTC() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = .utcFormatString
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")

        let dt = dateFormatter.date(from: self)
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = .appTimeFormat

        return dateFormatter.string(from: dt!)
    }
    
}
