//
//  String.swift
//  CarFitApplication
//
//  Created by Usman on 10/08/2020.
//  Copyright © 2020 usman-pucit All rights reserved.
//

import Foundation

// MARK: - Extension

extension String {
    // Property for local time to UTC string

    var localTimeToUtcTime: String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = .utcFormatString
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")

        guard let dt = dateFormatter.date(from: self) else { return nil }
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = .appTimeFormat

        return dateFormatter.string(from: dt)
    }
}
