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

// Abstract methods
protocol HomeViewModelType: class {
    associatedtype Output
    func jobSchedules(with fileName: String) -> Output
}

// MARK: Class

// ViewModel
final class HomeViewModel {
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
    typealias Output = AnyPublisher<CFResult<[HomeTableViewCellModel]>, Never>

    // MARK: - Function

    /// fetching car wash job schedules

    func jobSchedules(with fileName: String) -> AnyPublisher<CFResult<[HomeTableViewCellModel]>, Never> {
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()

        let outPut = useCase.jobSchedules(with: fileName)
            .map({ (result) -> CFResult<[HomeTableViewCellModel]> in
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
            return HomeTableViewCellModelBuilder.viewModel(from: job)
        }
    }

}
