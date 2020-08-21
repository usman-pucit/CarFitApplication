//
//  Decodable.swift
//  CarFitApplication
//
//  Created by Usman on 07/08/2020.
//  Copyright © 2020 usman-pucit All rights reserved.
//

import Combine
import Foundation

// MARK: - Extension

extension Decodable {
    // MARK: - Function

    static func parseJSON(with fileName: String) -> AnyPublisher<Result<Self, APIError>, Never> {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "json"),
            let data = try? Data(contentsOf: url),
            let output = try? JSONDecoder().decode(self, from: data)

        else {
            return Just<Result<Self, APIError>>(.failure(APIError.invalidResponse)).eraseToAnyPublisher()
        }
        return Just<Result<Self, APIError>>(.success(output)).eraseToAnyPublisher()
    }
}
