//
//  MockApiClient.swift
//  CarFitApplication
//
//  Created by Usman on 07/08/2020.
//  Copyright © 2020 usman-pucit All rights reserved.
//

import Foundation

// MARK: Struct MockApiClient for mock data

struct MockApiClient: APIClientProtocol {
 
    // MARK: - Function
    // Perform request function for mock data from JSON file
    func performRequestFromMock<T: Decodable>(with fileName: String, onResult: @escaping (Result<T>) -> ()) {
        
        if let response = T.parseJSON(with: fileName){ onResult(.success(response)) } else { onResult(.failure(.responseError)) }
    }
    
}
