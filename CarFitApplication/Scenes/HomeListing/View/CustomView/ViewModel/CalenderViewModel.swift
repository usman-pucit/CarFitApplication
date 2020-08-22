//
//  CalenderViewModel.swift
//  CarFitApplication
//
//  Created by Usman on 10/08/2020.
//  Copyright © 2020 usman-pucit All rights reserved.
//

import Combine
import Foundation

// MARK: - Enum

enum SelectedMonth {
    case current
    case next
    case previous
}

// MARK: - Protocol

// ViewModel Contract
protocol CalenderViewModelType: class {
    associatedtype Output
    func setCalneder(to month: SelectedMonth) -> Output
}

// MARK: - Class

final class CalenderViewModel {
    // MARK: - Properties

    private var dataSource: [CalenderDaysModel] = []
    private var calenderModel: CalenderModel!

    var numberOfRows: Int {
        return calenderModel.days.count
    }

    var monthAndYear: String {
        return calenderModel.monthAndYear
    }

    var selectedIndexPath: IndexPath {
        return IndexPath(row: (Int(calenderModel.today ?? "0") ?? 0) - 1, section: 0)
    }

    subscript(rowValue atIndexPath: Int) -> CalenderDaysModel {
        return calenderModel.days[atIndexPath]
    }

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

extension CalenderViewModel: CalenderViewModelType {
    // Publisher
    typealias Output = AnyPublisher<Result<CalenderModel, APIError>, Never>

    // MARK: - Function

    /// Set caleder with current, next and previous months

    func setCalneder(to month: SelectedMonth) -> AnyPublisher<Result<CalenderModel, APIError>, Never> {
        switch month {
        case .current: break
        case .next: Date.selectedDate = Date.selectedDate.nextMonth
        case .previous: Date.selectedDate = Date.selectedDate.previosMonth
        }
        calenderModel = daysInMonthModel()
        return .just(.success(calenderModel))
    }
}
