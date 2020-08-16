//
//  DatasourceContract.swift
//  CarFitApplication
//
//  Created by Muhammad Usman on 09/08/2020.
//  Copyright © 2020 usman. All rights reserved.
//

import UIKit

// MARK: - Protocol for Datasource contract
protocol DatasourceContract{
    
    // MARK: - Properties
    // associatedtype for model class assigned to cell at runtime.
    associatedtype Model
    
    // MARK: - update cell function to map datasource on UI
    func updateCell(object: Model)
}

