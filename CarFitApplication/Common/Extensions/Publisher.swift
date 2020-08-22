//
//  Publisher.swift
//  CarFitApplication
//
//  Created by Usman on 22/08/2020.
//  Copyright © 2020 usman-pucit. All rights reserved.
//

import Combine
import Foundation

// MARK: - Extension

extension Publisher {
    static func empty() -> AnyPublisher<Output, Failure> {
        return Empty().eraseToAnyPublisher()
    }

    static func just(_ output: Output) -> AnyPublisher<Output, Failure> {
        return Just(output)
            .catch { _ in AnyPublisher<Output, Failure>.empty() }
            .eraseToAnyPublisher()
    }

    static func fail(_ error: Failure) -> AnyPublisher<Output, Failure> {
        return Fail(error: error).eraseToAnyPublisher()
    }
}
