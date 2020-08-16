//
//  CFSchedulesResponseModel.swift
//  CarFitApplication
//
//  Created by Muhammad Usman on 07/08/2020.
//  Copyright © 2020 usman. All rights reserved.
//

import Foundation

// MARK: Response Model

struct CFSchedulesResponseModel: Codable {
    var success: Bool?
    var message: String?
    var data: [CFScheduleInformationModel]?
    var code: Int?

    enum CodingKeys: String, CodingKey {
        case success
        case message
        case data
        case code
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        success = try values.decodeIfPresent(Bool.self, forKey: .success)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        data = try values.decodeIfPresent([CFScheduleInformationModel].self, forKey: .data)
        code = try values.decodeIfPresent(Int.self, forKey: .code)
    }
}
