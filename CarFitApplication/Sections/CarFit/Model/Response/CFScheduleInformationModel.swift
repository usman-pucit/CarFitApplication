//
//  CFScheduleInformationModel.swift
//  CarFitApplication
//
//  Created by Usman on 07/08/2020.
//  Copyright © 2020 usman-pucit All rights reserved.
//

import Foundation
import UIKit

// MARK: - Enum for Visit States and Color mapping

enum VisitStates: String {
    case ToDo
    case InProgress
    case Done
    case Rejected

    var color: UIColor {
        switch self {
        case .ToDo:
            return .toDoStateColor
        case .InProgress:
            return .inProgressOption
        case .Done:
            return .doneStateColor
        case .Rejected:
            return .rejectedStateColor
        }
    }
}

// MARK: Information Model

struct CFScheduleInformationModel: Codable {
    let visitId: String?
    let homeBobEmployeeId: String?
    let houseOwnerId: String?
    let isBlocked: Bool?
    let startTimeUtc: String?
    let endTimeUtc: String?
    let title: String?
    let isReviewed: Bool?
    let isFirstVisit: Bool?
    let isManual: Bool?
    let visitTimeUsed: Int?
    let rememberToday: String?
    let houseOwnerFirstName: String?
    let houseOwnerLastName: String?
    let houseOwnerMobilePhone: String?
    let houseOwnerAddress: String?
    let houseOwnerZip: String?
    let houseOwnerCity: String?
    let houseOwnerLatitude: Double?
    let houseOwnerLongitude: Double?
    let isSubscriber: Bool?
    let rememberAlways: String?
    let professional: String?
    let visitState: String?
    let stateOrder: Int?
    let expectedTime: String?
    let tasks: [CFScheduledTaskModels]?
    let houseOwnerAssets: [String]?
    let visitAssets: [String]?
    let visitMessages: [String]?
    let statusColor: UIColor?

    enum CodingKeys: String, CodingKey {
        case visitId
        case homeBobEmployeeId
        case houseOwnerId
        case isBlocked
        case startTimeUtc
        case endTimeUtc
        case title
        case isReviewed
        case isFirstVisit
        case isManual
        case visitTimeUsed
        case rememberToday
        case houseOwnerFirstName
        case houseOwnerLastName
        case houseOwnerMobilePhone
        case houseOwnerAddress
        case houseOwnerZip
        case houseOwnerCity
        case houseOwnerLatitude
        case houseOwnerLongitude
        case isSubscriber
        case rememberAlways
        case professional
        case visitState
        case stateOrder
        case expectedTime
        case tasks
        case houseOwnerAssets
        case visitAssets
        case visitMessages
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        visitId = try values.decodeIfPresent(String.self, forKey: .visitId)
        homeBobEmployeeId = try values.decodeIfPresent(String.self, forKey: .homeBobEmployeeId)
        houseOwnerId = try values.decodeIfPresent(String.self, forKey: .houseOwnerId)
        isBlocked = try values.decodeIfPresent(Bool.self, forKey: .isBlocked)
        startTimeUtc = try values.decodeIfPresent(String.self, forKey: .startTimeUtc)
        endTimeUtc = try values.decodeIfPresent(String.self, forKey: .endTimeUtc)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        isReviewed = try values.decodeIfPresent(Bool.self, forKey: .isReviewed)
        isFirstVisit = try values.decodeIfPresent(Bool.self, forKey: .isFirstVisit)
        isManual = try values.decodeIfPresent(Bool.self, forKey: .isManual)
        visitTimeUsed = try values.decodeIfPresent(Int.self, forKey: .visitTimeUsed)
        rememberToday = try values.decodeIfPresent(String.self, forKey: .rememberToday)
        houseOwnerFirstName = try values.decodeIfPresent(String.self, forKey: .houseOwnerFirstName)
        houseOwnerLastName = try values.decodeIfPresent(String.self, forKey: .houseOwnerLastName)
        houseOwnerMobilePhone = try values.decodeIfPresent(String.self, forKey: .houseOwnerMobilePhone)
        houseOwnerAddress = try values.decodeIfPresent(String.self, forKey: .houseOwnerAddress)
        houseOwnerZip = try values.decodeIfPresent(String.self, forKey: .houseOwnerZip)
        houseOwnerCity = try values.decodeIfPresent(String.self, forKey: .houseOwnerCity)
        houseOwnerLatitude = try values.decodeIfPresent(Double.self, forKey: .houseOwnerLatitude)
        houseOwnerLongitude = try values.decodeIfPresent(Double.self, forKey: .houseOwnerLongitude)
        isSubscriber = try values.decodeIfPresent(Bool.self, forKey: .isSubscriber)
        rememberAlways = try values.decodeIfPresent(String.self, forKey: .rememberAlways)
        professional = try values.decodeIfPresent(String.self, forKey: .professional)
        visitState = try values.decodeIfPresent(String.self, forKey: .visitState)
        stateOrder = try values.decodeIfPresent(Int.self, forKey: .stateOrder)
        expectedTime = try values.decodeIfPresent(String.self, forKey: .expectedTime)
        tasks = try values.decodeIfPresent([CFScheduledTaskModels].self, forKey: .tasks)
        houseOwnerAssets = try values.decodeIfPresent([String].self, forKey: .houseOwnerAssets)
        visitAssets = try values.decodeIfPresent([String].self, forKey: .visitAssets)
        visitMessages = try values.decodeIfPresent([String].self, forKey: .visitMessages)
        statusColor = VisitStates(rawValue: visitState ?? "")?.color ?? .defaultStateColor
    }
}
