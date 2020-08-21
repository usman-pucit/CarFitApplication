//
//  APIClientType.swift
//  CarFitApplication
//
//  Created by Usman on 07/08/2020.
//  Copyright © 2020 usman-pucit All rights reserved.
//

import Combine
import Foundation

// MARK: - Enum

/// Enum for request failures with error messages

enum APIError: String, Error {
    case invalidResponse = "Invalid response"
}

// MARK: - Enum

/// Enum for handling values and data results in a correct way.

enum CFResult<Value> {
    case success(Value)
    case failure(APIError)
}

// MARK: - APIClientType protocol

/// An Abstract methods protocol to setup multiple environments.
/// It can be injected with a single dependency to perform requests on like Mock and SOAP/REST environments.

protocol APIClientType {
    @discardableResult
    func execute<T: Decodable>(with fileName: String) -> AnyPublisher<Result<T, APIError>, Never>
}
