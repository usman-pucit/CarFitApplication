//
//  CalenderModel.swift
//  CarFitApplication
//
//  Created by Muhammad Usman on 10/08/2020.
//  Copyright © 2020 usman. All rights reserved.
//

import Foundation

// MARK: - Struct Month Model

struct CalenderModel {
    let monthAndYear: String
    var today: String? = Date().today
    let days: [CalenderDaysModel]

    init(monthAndYear: String, days: [CalenderDaysModel]) {
        self.monthAndYear = monthAndYear
        self.days = days
    }
}

// MARK: - Struct Day Model

struct CalenderDaysModel {
    let day: String
    let weekday: String
    let date: String

    init(day: String, weekday: String, date: String) {
        self.day = day
        self.weekday = weekday
        self.date = date
    }
}
