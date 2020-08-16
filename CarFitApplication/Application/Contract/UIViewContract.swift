//
//  ReusableContracts.swift
//  CarFitApplication
//
//  Created by Muhammad Usman on 09/08/2020.
//  Copyright © 2020 usman. All rights reserved.
//

import UIKit

// MARK: - protocol ResuableViews

protocol ResuableViews {
    static var reuseIdentifier: String { get }
}

// MARK: - extension ResuableViews

extension ResuableViews where Self: UIView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

// MARK: - Protocol NibLoadableView

protocol NibLoadableView: class {
    static var nibName: String { get }
}

// MARK: - extension NibLoadableView

extension NibLoadableView where Self: UIView {
    static var nibName: String {
        return String(describing: self)
    }
}

