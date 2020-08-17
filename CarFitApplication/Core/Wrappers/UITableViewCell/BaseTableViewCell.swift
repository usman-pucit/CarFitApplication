//
//  BaseTableViewCell.swift
//  CarFitApplication
//
//  Created by Usman on 12/08/2020.
//  Copyright © 2020 usman-pucit All rights reserved.
//

import UIKit

// MARK: - Class

// BaseTableViewCell class to write down shared properties and function and to achive polymorphic behaviour when required
class BaseTableViewCell: UITableViewCell {}

// MARK: - Extension

// Confirming Reusable protocols and Nib protocols at Base level
extension BaseTableViewCell: NibLoadableView, ResuableViews {}
