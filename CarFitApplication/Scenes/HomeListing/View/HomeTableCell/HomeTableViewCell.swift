//
//  HomeTableViewCell.swift
//  Calendar
//
//  Test Project
//

import CoreLocation
import UIKit

// MARK: Class HomeTableViewCell

class HomeTableViewCell: UITableViewCell {
    // MARK: IBOutlets

    @IBOutlet var bgView: UIView!
    @IBOutlet var customer: UILabel!
    @IBOutlet var statusView: UIView!
    @IBOutlet var status: UILabel!
    @IBOutlet var tasks: UILabel!
    @IBOutlet var arrivalTime: UILabel!
    @IBOutlet var destination: UILabel!
    @IBOutlet var timeRequired: UILabel!
    @IBOutlet var distance: UILabel!

    // MARK: Properties

    typealias Model = CFScheduleInformationModel

    // MARK: Life cycle

    override func awakeFromNib() {
        super.awakeFromNib()
        bgView.layer.cornerRadius = 10.0
        statusView.layer.cornerRadius = status.frame.height / 2.0
        statusView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
    }
}

// MARK: - Extension Datasource Contract

extension HomeTableViewCell: DatasourceContract {
    // MARK: Function to update cell

    func updateCell(object: Model) {
        if let tasksObj = object.tasks {
            let title = tasksObj.map({ ($0.title ?? "") }).joined(separator: ",")
            let timeInMinutes = tasksObj.map({ ($0.timesInMinutes ?? 0) }).reduce(0, +)
            tasks.text = title
            timeRequired.text = "\(timeInMinutes) min"
        }
        statusView.backgroundColor = object.statusColor
        customer.text = (object.houseOwnerFirstName ?? "") + " " + (object.houseOwnerLastName ?? "")
        var arrivalTimeString : String = object.startTimeUtc?.localTimeToUtcTime ?? ""
        if let expectedTime = object.expectedTime{
            arrivalTimeString = arrivalTimeString + " / " + expectedTime.replacingOccurrences(of: "/", with: "-")
        }
        arrivalTime.text = arrivalTimeString
        status.text = object.visitState
        destination.text = (object.houseOwnerAddress ?? "") + (object.houseOwnerZip ?? "") + (object.houseOwnerCity ?? "")
        distance.text = "\(((object.houseOwnerLatitude ?? 0.0) + (object.houseOwnerLongitude ?? 0.0)).round(to: 1)) Km"
    }
}

