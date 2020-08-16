//
//  MockApiClient.swift
//  CarFitApplication
//
//  Created by Muhammad Usman on 07/08/2020.
//  Copyright © 2020 usman. All rights reserved.
//

import Foundation

// MARK: Struct MockApiClient for mock data

struct MockApiClient<T: Decodable>: APIClientProtocol {
 
    // MARK: - Function
    // Perform request function for mock data from JSON file
    func performRequestFromMock<T: Decodable>(with fileName: String, onSuccess: @escaping (T) -> (), onError: @escaping (APIError) -> ()) {
        
        if let response = T.parseJSON(with: fileName){ onSuccess(response) } else { onError(.responseError) }
    }
    
}
