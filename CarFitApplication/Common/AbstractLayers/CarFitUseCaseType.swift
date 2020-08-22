//
//  CarFitUseCaseType.swift
//  CarFitApplication
//
//  Created by Usman on 22/08/2020.
//  Copyright © 2020 usman-pucit. All rights reserved.
//

import Combine
import Foundation

// MARK: - Protocol

/// Abstract functions
protocol CarFitUseCaseType {
    func jobSchedules(with fileName: String) -> AnyPublisher<Result<[CFScheduleInformationModel], APIError>, Never>
}

