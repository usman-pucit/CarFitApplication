//
//  DatasourceContract.swift
//  CarFitApplication
//
//  Created by Usman on 09/08/2020.
//  Copyright © 2020 usman-pucit All rights reserved.
//

import UIKit

// MARK: - Protocol

// A protocol with abstract methods
protocol DatasourceType {
    // MARK: - Properties

    associatedtype Datasource

    // MARK: - Function

    // Method to bind Cell with Datasource

    func updateCell(object: Datasource)
}
