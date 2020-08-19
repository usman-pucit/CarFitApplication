//
//  DayCell.swift
//  Calendar
//
//  Test Project
//

import UIKit

// MARK: - Class

// UICollectionViewCell to show days of each month in calender view
class DayCell: UICollectionViewCell {
    // MARK: - IBOutlets

    @IBOutlet var dayView: UIView!
    @IBOutlet var day: UILabel!
    @IBOutlet var weekday: UILabel!

    // MARK: -  Properties

    typealias Datasource = CalenderDaysModel

    override var isSelected: Bool {
        willSet {
            dayView.backgroundColor = newValue == true ? .selectedDayColor : .clear
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        dayView.layer.cornerRadius = dayView.frame.width / 2.0
        dayView.backgroundColor = .clear
    }
}

// MARK: -  Extension

// Confirming Datasource contract functions

extension DayCell: DatasourceContract {
    // MARK: Function to update cell

    func updateCell(object: Datasource) {
        day.text = object.day
        weekday.text = object.weekday
    }
}
