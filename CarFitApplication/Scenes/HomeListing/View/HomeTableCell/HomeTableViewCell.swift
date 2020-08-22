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

    typealias Datasource = HomeTableViewCellModel

    // MARK: Life cycle

    override func awakeFromNib() {
        super.awakeFromNib()
        bgView.layer.cornerRadius = 10.0
        statusView.layer.cornerRadius = status.frame.height / 2.0
        statusView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
    }
}

// MARK: - Extension Datasource Contract

extension HomeTableViewCell: DatasourceType {
    // MARK: Function to update cell

    func updateCell(object: Datasource) {
        statusView.backgroundColor = object.statusViewColor
        customer.text = object.customer
        arrivalTime.text = object.arrivalTime
        status.text = object.status
        destination.text = object.destination
        distance.text = object.distance
        tasks.text = object.tasks
        timeRequired.text = object.timeRequired
    }
}
