//
//  MainInteractor.swift
//  CarFitApplication
//
//  Created by Usman on 07/08/2020.
//  Copyright © 2020 usman-pucit All rights reserved.
//

import Foundation

// MARK: - Enum

// Enum for request failures with error messages

enum APIError: String, Error {
    case responseError = "Serialization error"
}

// MARK: - Enum

// Enum for handling values and data results in a correct way.

enum Result<Value> {
    case success(Value)
    case failure(APIError)
}

// MARK: - APIClient protocol

/// A protocol to setup multiple request setup and to ease Unit Testing
/// It can be injected with a single dependency to perform requests on like Mock and SOAP/REST environments.

protocol APIClientProtocol {
    func performRequestFromMock<T: Decodable>(with fileName: String, onResult: @escaping (Result<T>) -> ())
}
