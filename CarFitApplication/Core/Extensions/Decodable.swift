//
//  Decodable.swift
//  CarFitApplication
//
//  Created by Muhammad Usman on 07/08/2020.
//  Copyright © 2020 usman. All rights reserved.
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

// MARK: - Extension

extension Encodable {
    // MARK: - Property to get dictioary object by encoding

    var dictionary: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
    }
}
