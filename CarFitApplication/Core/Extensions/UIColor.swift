//
//  UIColor.swift
//  CarFitApplication
//
//  Created by Muhammad Usman on 10/08/2020.
//  Copyright © 2020 usman. All rights reserved.
//

import UIKit

// MARK: - Extension UIColor

extension UIColor {
    // MARK: Properties

    // HEX Colors
    static let selectedDayColor = UIColor(hexString: "#3E876E")
    static let toDoStateColor = UIColor(hexString: "#4E77D6")
    static let inprogressStateColor = UIColor(hexString: "#F5C709")
    static let doneStateColor = UIColor(hexString: "#25A87B")
    static let rejectedStateColor = UIColor(hexString: "#EF6565")
    static let defaultStateColor = UIColor(hexString: "#4E77D6")

    // RGB Colors
    static let daySelected = UIColor(red: 62 / 255.0, green: 133 / 255.0, blue: 112 / 255.0, alpha: 1.0)
    static let doneOption = UIColor(red: 46 / 255.0, green: 168 / 255.0, blue: 137 / 255.0, alpha: 1.0)
    static let inProgressOption = UIColor(red: 240 / 255.0, green: 198 / 255.0, blue: 23 / 255.0, alpha: 1.0)
    static let todoOption = UIColor(red: 91 / 255.0, green: 127 / 255.0, blue: 224 / 255.0, alpha: 1.0)
    static let rejectedOption = UIColor(red: 239 / 255.0, green: 101 / 255.0, blue: 101 / 255.0, alpha: 1.0)

    // MARK: - Initializer with hex string

    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}
