//
//  Scheduler.swift
//  CarFitApplication
//
//  Created by Usman on 21/08/2020.
//  Copyright © 2020 usman-pucit. All rights reserved.
//

import Combine
import Foundation

// MARK: - Class

/// Scheduler class to manage Background Oprations
final class Scheduler {
    static let mainScheduler = RunLoop.main

    static var backgroundWorkScheduler: OperationQueue = {
        let operationQueue = OperationQueue()
        operationQueue.maxConcurrentOperationCount = 1
        operationQueue.qualityOfService = QualityOfService.userInitiated
        return operationQueue
    }()
}
