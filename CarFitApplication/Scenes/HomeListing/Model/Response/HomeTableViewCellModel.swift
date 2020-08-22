//
//  HomeTableViewCellModel.swift
//  CarFitApplication
//
//  Created by Muhammad Usman on 22/08/2020.
//  Copyright © 2020 usman. All rights reserved.
//

import Combine
import UIKit

struct HomeTableViewCellModel {
    var statusViewColor: UIColor
    var customer: String
    var arrivalTime: String
    var status: String
    var destination: String
    var distance: String
    var tasks: String
    var timeRequired: String

    init(statusViewColor: UIColor, customer: String, arrivalTime: String, status: String, destination: String, distance: String, tasks: String, timeRequired: String) {
        self.statusViewColor = statusViewColor
        self.customer = customer
        self.arrivalTime = arrivalTime
        self.status = status
        self.destination = destination
        self.distance = distance
        self.tasks = tasks
        self.timeRequired = timeRequired
    }
}

// HomeTableViewCellModel Builder
struct HomeTableViewCellModelBuilder {
    static func viewModel(from scheduleInfo: CFScheduleInformationModel) -> HomeTableViewCellModel {
        let statusColor: UIColor = scheduleInfo.statusColor ?? .defaultStateColor
        let customer: String = (scheduleInfo.houseOwnerFirstName ?? "") + " " + (scheduleInfo.houseOwnerLastName ?? "")
        var arrivalTime: String = scheduleInfo.startTimeUtc?.localTimeToUtcTime ?? ""
        if let expectedTime = scheduleInfo.expectedTime {
            arrivalTime = arrivalTime + " / " + expectedTime.replacingOccurrences(of: "/", with: "-")
        }
        let status: String = scheduleInfo.visitState ?? ""

        let destination: String = (scheduleInfo.houseOwnerAddress ?? "") + (scheduleInfo.houseOwnerZip ?? "") + (scheduleInfo.houseOwnerCity ?? "")

        let distance: String = "\(((scheduleInfo.houseOwnerLatitude ?? 0.0) + (scheduleInfo.houseOwnerLongitude ?? 0.0)).round(to: 1)) Km"
        var task: String = ""
        var timeRequired: String = ""
        if let taskObjects = scheduleInfo.tasks {
            let title = taskObjects.map({ ($0.title ?? "") }).joined(separator: ",")
            let timeInMinutes = taskObjects.map({ ($0.timesInMinutes ?? 0) }).reduce(0, +)
            task = title
            timeRequired = "\(timeInMinutes) min"
        }

        return HomeTableViewCellModel(statusViewColor: statusColor,
                                      customer: customer,
                                      arrivalTime: arrivalTime,
                                      status: status,
                                      destination: destination,
                                      distance: distance,
                                      tasks: task,
                                      timeRequired: timeRequired)
    }
}
