//
//  HomeListingUseCase.swift
//  CarFitApplication
//
//  Created by Usman on 08/08/2020.
//  Copyright © 2020 usman-pucit All rights reserved.
//

import Combine
import Foundation

// MARK: - Protocol

// CarFitUseCaseType Usecase.
protocol CarFitUseCaseType {
    func jobSchedules(with fileName: String) -> AnyPublisher<Result<[CFScheduleInformationModel], APIError>, Never>
}

// MARK: - Class

//  HomeListingUseCase for HomeListing

final class HomeListingUseCase {
    // MARK: -  Properties

    var apiClient: APIClientType

    // MARK: - Initializer

    // Dependency of APIClientType
    init(apiClient: APIClientType = MockApiClient()) {
        self.apiClient = apiClient
    }
}

// MARK: - Extension

extension HomeListingUseCase: CarFitUseCaseType {
    // MARK: - Function to fetch jobs list

    func jobSchedules(with fileName: String) -> AnyPublisher<Result<[CFScheduleInformationModel], APIError>, Never> {
        return apiClient.execute(with: fileName).map({ (result: Result<CFSchedulesResponseModel, APIError>) -> Result<[CFScheduleInformationModel], APIError> in
            switch result {
            case .success(let jobs):
                return .success(jobs.data ?? [])
            case .failure(let error):
                return .failure(error)
            }
            }).subscribe(on: Scheduler.backgroundWorkScheduler)
            .receive(on: Scheduler.mainScheduler)
            .eraseToAnyPublisher()
    }
}
