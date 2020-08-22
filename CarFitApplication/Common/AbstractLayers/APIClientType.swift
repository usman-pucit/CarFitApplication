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

// MARK: - APIClientType protocol

/// Abstract functions for different environments.
/// Can be injected with DI to work with Mock and SOAP/REST etc  environments.

protocol APIClientType {
    @discardableResult
    func execute<T: Decodable>(with fileName: String) -> AnyPublisher<Result<T, APIError>, Never>
}
