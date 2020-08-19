//
//  CalenderViewModel.swift
//  CarFitApplication
//
//  Created by Usman on 10/08/2020.
//  Copyright © 2020 usman-pucit All rights reserved.
//

import Combine
import Foundation

enum CalenderMonth {
    case current
    case next
    case previous
}

// MARK: - Class for ViewModel

class CalenderViewModel: ObservableObject {
    // MARK: - Properties

    // Publisher properties to publish data change

    @Published private(set) var calenderModel: CalenderModel!

    // MARK: - Function

    // Setting caleder to month current/next/previous

    func onSetCalneder(to month: CalenderMonth) {
        switch month {
        case .current:
            calenderModel = daysInMonthModel()
        case .next:
            Date.selectedDate = Date.selectedDate.nextMonth
            calenderModel = daysInMonthModel()
        case .previous:
            Date.selectedDate = Date.selectedDate.previosMonth
            calenderModel = daysInMonthModel()
        }
    }

    // MARK: - Function

    // Preparing datasource with days in a month

    private func daysInMonthModel() -> CalenderModel {
        let datesInCurrentMonth = Date().datesInCurrentMonth()
        var daysInMonthArray = [CalenderDaysModel]()

        for date in datesInCurrentMonth {
            let daysModel = CalenderDaysModel(day: date.dateComponents.day, weekday: date.dateComponents.weekday, date: date.dateComponents.date)
            daysInMonthArray.append(daysModel)
        }
        return CalenderModel(monthAndYear: Date.selectedDate.monthAndYear, days: daysInMonthArray)
    }
}
