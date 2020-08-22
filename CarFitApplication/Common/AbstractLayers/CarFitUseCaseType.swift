//
//  CarFitUseCaseType.swift
//  CarFitApplication
//
//  Created by Muhammad Usman on 22/08/2020.
//  Copyright © 2020 usman. All rights reserved.
//

import Combine
import Foundation

// MARK: - Protocol

/// Abstract methods
protocol CarFitUseCaseType {
    func jobSchedules(with fileName: String) -> AnyPublisher<Result<[CFScheduleInformationModel], APIError>, Never>
}

