//
//  CleanerListViewModel.swift
//  CarFitApplication
//
//  Created by Usman on 08/08/2020.
//  Copyright © 2020 usman-pucit All rights reserved.
//

import Combine
import Foundation

// MARK: - Protocol

/// Abstract functions

protocol CleanerListViewModelType: class {
    associatedtype Output
    func jobSchedules(with fileName: String) -> Output
}

// MARK: Class

/// ViewModel
final class CleanerListViewModel {
    // MARK: Properties

    private var dataSource: [HomeTableViewCellModel] = []
    private var error: APIError?
    private var cancellables: [AnyCancellable] = []
    private var useCase: CarFitUseCaseType

    var numberOfRows: Int {
        return dataSource.count
    }

    var errorString: String? {
        return error?.rawValue
    }

    subscript(rowValue atIndexPath: Int) -> HomeTableViewCellModel {
        return dataSource[atIndexPath]
    }


    // MARK: Initializer

    /// Dependency of APIClient
    init(useCase: CarFitUseCaseType) {
        self.useCase = useCase
    }
}

// MARK: - Extension

extension CleanerListViewModel: CleanerListViewModelType {
    /// Publisher
    typealias Output = AnyPublisher<Result<[HomeTableViewCellModel], APIError>, Never>

    // MARK: - Function

    /// fetching car wash job schedules

    func jobSchedules(with fileName: String) -> AnyPublisher<Result<[HomeTableViewCellModel], APIError>, Never> {
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()

        let outPut = useCase.jobSchedules(with: fileName)
            .map({ (result) -> Result<[HomeTableViewCellModel], APIError> in
                switch result {
                case .success(let jobSchedules):
                    self.dataSource = self.viewModels(from: jobSchedules)
                    return .success(self.viewModels(from: jobSchedules))
                case .failure(let error):
                    self.error = error
                    return .failure(error)
                }
            })
            .eraseToAnyPublisher()

        return Publishers.MergeMany(outPut).eraseToAnyPublisher()
    }

    private func viewModels(from jobSchedules: [CFScheduleInformationModel]) -> [HomeTableViewCellModel] {
        return jobSchedules.map { (job) -> HomeTableViewCellModel in
            HomeTableViewCellModelBuilder.viewModel(from: job)
        }
    }
}
