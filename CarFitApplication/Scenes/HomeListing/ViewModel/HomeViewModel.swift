//
//  HomeViewModel.swift
//  CarFitApplication
//
//  Created by Usman on 08/08/2020.
//  Copyright © 2020 usman-pucit All rights reserved.
//

import Combine
import Foundation

// MARK: Class for ViewModel

class HomeViewModel: ObservableObject {
    // MARK: Properties
    
    // Publisher properties to publish data change
    
    @Published private(set) var dataSource: CFSchedulesResponseModel?
    @Published private(set) var error: APIError?
    
    private var apiClient: APIClientProtocol
    private var homeUseCase: HomeListingUseCase
    
    // MARK: Initializer
    
    // Dependency of APIClient
    init(apiClient: APIClientProtocol) {
        self.apiClient = apiClient
        homeUseCase = HomeListingUseCase(apiClient: apiClient)
    }
    
    // MARK: - Function to perform data request
    
    internal func performRequestWithMock(fileName: String = .mockFileName) {
        homeUseCase.performRequestWithMock(with: fileName) { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let response):
                strongSelf.dataSource = response
            case .failure(let error):
                strongSelf.error = error
            }
        }
    }
}
