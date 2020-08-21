//
//  HomeViewModel.swift
//  CarFitApplication
//
//  Created by Usman on 08/08/2020.
//  Copyright © 2020 usman-pucit All rights reserved.
//

import Combine
import Foundation

// MARK: - Protocol

// ViewModel Contract
protocol HomeViewModelType: class {
    associatedtype Output
    func jobSchedules(with fileName: String) -> Output
}

// MARK: Class

// ViewModel
final class HomeViewModel {
    // MARK: Properties

    private var dataSource: [CFScheduleInformationModel] = []
    private var error: APIError?
    private var cancellables: [AnyCancellable] = []
    private var useCase: CarFitUseCaseType

    var numberOfRows: Int {
        return dataSource.count
    }

    var errorString: String? {
        return error?.rawValue
    }

    subscript(rowValue atIndexPath: Int) -> CFScheduleInformationModel {
        return dataSource[atIndexPath]
    }

//    private var apiClient: APIClientType

    // MARK: Initializer

    // Dependency of APIClient
    init(useCase: CarFitUseCaseType) {
        self.useCase = useCase
    }
}

// MARK: - Extension

extension HomeViewModel: HomeViewModelType {
    // Publisher
    typealias Output = AnyPublisher<CFResult<[CFScheduleInformationModel]>, Never>

    // MARK: - Function to fetch all job schedules with with mock response.

    func jobSchedules(with fileName: String) -> AnyPublisher<CFResult<[CFScheduleInformationModel]>, Never> {
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()

        let outPut = useCase.jobSchedules(with: fileName)
            .map({ (result) -> CFResult<[CFScheduleInformationModel]> in
                switch result {
                case .success(let jobs):
                    self.dataSource = jobs
                    return .success(jobs)
                case .failure(let error):
                    self.error = error
                    return .failure(error)
                }
            })
            .eraseToAnyPublisher()

        return Publishers.MergeMany(outPut).eraseToAnyPublisher()
    }
}
