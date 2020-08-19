//
//  Decodable.swift
//  CarFitApplication
//
//  Created by Usman on 07/08/2020.
//  Copyright © 2020 usman-pucit All rights reserved.
//

import Foundation

// MARK: - Extension Decodable

extension Decodable {
    // MARK: - Function to parse JSON mock file into decodable

    static func parseJSON(with fileName: String) -> Self? {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "json"),
            let data = try? Data(contentsOf: url),
            let output = try? JSONDecoder().decode(self, from: data)
        else {
            return nil
        }
        return output
    }
}
