//
//  BaseTableViewCell.swift
//  CarFitApplication
//
//  Created by Muhammad Usman on 12/08/2020.
//  Copyright © 2020 usman. All rights reserved.
//

import UIKit

// MARK: - Class

// BaseTableViewCell class to write down shared properties and function and to achive polymorphic behaviour when required
class BaseTableViewCell: UITableViewCell {}

// MARK: - Extension

// Confirming Reusable protocols and Nib protocols at Base level
extension BaseTableViewCell: NibLoadableView, ResuableViews {}
