//
//  CarFitInteractor.swift
//  CarFitApplication
//
//  Created by Muhammad Usman on 08/08/2020.
//  Copyright © 2020 usman. All rights reserved.
//

import Foundation

// MARK: - Class

// CarFitInteractor for data handler in our case fetch data with a mock JSON file.
class CarFitInteractor {
    // MARK: -  Properties

    var apiClient: APIClientProtocol

    // MARK: - Initializer

    // Dependency of APIClientProtocol
    init(apiClient: APIClientProtocol) {
        self.apiClient = apiClient
    }

    // MARK: - Function to perform mock request

    func performRequestFromMock(with fileName: String, onSuccess: @escaping (CFSchedulesResponseModel) -> (), onError: @escaping (APIError) -> ()) {
        apiClient.performRequestFromMock(with: fileName, onSuccess: onSuccess, onError: onError)
    }
}
