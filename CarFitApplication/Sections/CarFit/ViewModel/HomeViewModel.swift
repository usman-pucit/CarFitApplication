//
//  HomeViewModel.swift
//  CarFitApplication
//
//  Created by Muhammad Usman on 08/08/2020.
//  Copyright © 2020 usman. All rights reserved.
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
    private var interactor: CarFitInteractor
    
    // MARK: Initializer
    
    // Depenedcy of APIClient
    init(apiClient: APIClientProtocol) {
        self.apiClient = apiClient
        interactor = CarFitInteractor(apiClient: apiClient)
    }
    
    // MARK: - Function to perfom data request
    
    internal func performRequestFromMock(fileName: String = .mockFileName) {
        interactor.performRequestFromMock(with: fileName, onSuccess: { response in
            LogsManager.printLog(response.dictionary ?? [:])
            self.dataSource = response
        }) { error in
            self.error = error
        }
    }
}
