//
//  Double.swift
//  CarFitApplication
//
//  Created by Usman on 10/08/2020.
//  Copyright © 2020 usman-pucit All rights reserved.
//

import Foundation

// MARK: - Extension

extension Double {
    // MARK: - Function to round Double to a provided number

    func round(to places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
