//
//  HomeListingUseCase.swift
//  CarFitApplication
//
//  Created by Usman on 08/08/2020.
//  Copyright © 2020 usman-pucit All rights reserved.
//

import Foundation

// Protocol for MockListing Use case.
protocol MockListingUseCase {
    func performRequestWithMock(with fileName: String, onResult: @escaping (Result<CFSchedulesResponseModel>) -> ())
}

// MARK: - Class
//  HomeListingUseCase for HomeListing with a mock request.

final class HomeListingUseCase {
    // MARK: -  Properties

    var apiClient: APIClientProtocol

    // MARK: - Initializer

    // Dependency of APIClientProtocol
    init(apiClient: APIClientProtocol) {
        self.apiClient = apiClient
    }
}

// MARK: - Extension

extension HomeListingUseCase: MockListingUseCase {
    // MARK: - Function to perform mock request

    func performRequestWithMock(with fileName: String, onResult: @escaping (Result<CFSchedulesResponseModel>) -> ()) {
        apiClient.performRequestWithMock(with: fileName, onResult: onResult)
    }
}
