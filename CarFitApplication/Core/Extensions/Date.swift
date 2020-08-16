//
//  Date.swift
//  CarFitApplication
//
//  Created by Muhammad Usman on 10/08/2020.
//  Copyright © 2020 usman. All rights reserved.
//

import UIKit

// MARK: - Extension

extension Date {
    // MARK: Properties

    // shared selected date object

    static var selectedDate = Date()

    // Date for next month
    var nextMonth: Date {
        let calender = NSCalendar.current
        return calender.date(byAdding: .month, value: 1, to: .selectedDate)!
    }

    // Date for previous month
    var previosMonth: Date {
        let calender = NSCalendar.current
        return calender.date(byAdding: .month, value: -1, to: .selectedDate)!
    }

    // Formatted date string
    var formatedDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = .dateFormatString
        return dateFormatter.string(from: self)
    }

    // Month and year date string
    var monthAndYear: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = .monthAndYearFormat
        return dateFormatter.string(from: .selectedDate)
    }

    // Today day string
    var today: String? {
        if Date.selectedDate.formatedDate == Date().formatedDate {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = .dayFormat
            let day = dateFormatter.string(from: self)
            return day
        } else {
            return nil
        }
    }

    // Tuple
    // Date components with day and weekday strings
    var dateComponents: (day: String, weekday: String, date: String) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = .weekDayFormat
        let weekday = dateFormatter.string(from: self)
        dateFormatter.dateFormat = .dayFormat
        let day = dateFormatter.string(from: self)
        dateFormatter.dateFormat = .dateFormatString
        let date = dateFormatter.string(from: self)
        return (day, weekday, date)
    }

    // MARK: - Function

    // Dates for all the days in a selected month
    func datesInCurrentMonth() -> [Date] {
        let calendar = Calendar.current
        let date = Date.selectedDate
        let daysInMonthRange = calendar.range(of: .day, in: .month, for: date)

        if let daysInMonthRange = daysInMonthRange {
            let month = calendar.component(.month, from: date)
            let year = calendar.component(.year, from: date)

            var dates = [Date]()

            for dayOfMonth in daysInMonthRange.lowerBound..<daysInMonthRange.upperBound {
                let components = DateComponents(year: year, month: month, day: dayOfMonth)
                guard let date = Calendar.current.date(from: components) else { continue }
                dates.append(date)
            }

            return dates
        }

        return []
    }
}
