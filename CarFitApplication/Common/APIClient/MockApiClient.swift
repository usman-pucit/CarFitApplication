//
//  MockApiClient.swift
//  CarFitApplication
//
//  Created by Usman on 07/08/2020.
//  Copyright © 2020 usman-pucit All rights reserved.
//

import Combine
import Foundation

// MARK: MockApiClient

// A concrete class with APIClientType

final class MockApiClient: APIClientType {
    // MARK: - Function

    func execute<T>(with fileName: String) -> AnyPublisher<Result<T, APIError>, Never> where T: Decodable {
        return T.parseJSON(with: fileName)
            .subscribe(on: Scheduler.backgroundWorkScheduler)
            .receive(on: Scheduler.mainScheduler)
            .eraseToAnyPublisher()
    }
}
