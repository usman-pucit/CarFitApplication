//
//  CalendarView.swift
//  Calendar
//
//  Test Project
//

import Combine
import UIKit

protocol CalendarDelegate: class {
    func getSelectedDate(_ date: String)
}

// MARK: - Class CalendarView

class CalendarView: UIView {
    // MARK: IBOulets
    
    @IBOutlet var monthAndYear: UILabel!
    @IBOutlet var leftBtn: UIButton!
    @IBOutlet var rightBtn: UIButton!
    @IBOutlet var daysCollectionView: UICollectionView!
    
    // MARK: Properties
    
    private var calenderModel: CalenderModel!
    weak var delegate: CalendarDelegate?
    private var viewModel = CalenderViewModel()
    private var cancellable: AnyCancellable?
    private var selectedIndexPath: IndexPath?
    private var calenderDaysArray: [CalenderDaysModel] = [] {
        didSet {
            DispatchQueue.main.async {
                self.daysCollectionView.reloadData()
                self.daysCollectionView.selectItem(at: self.selectedIndexPath ?? IndexPath(row: 0, section: 0), animated: true, scrollPosition: .left)
                self.daysCollectionView.setNeedsLayout()
            }
        }
    }
    
    // MARK: - Initialize calendar
    
    private func initialize() {
        setupUI()
        onBindingViewModel()
    }
    
    // MARK: - Function
    
    private func setupUI() {
        daysCollectionView.registerNib(DayCell.self)
        daysCollectionView.delegate = self
        daysCollectionView.dataSource = self
    }
    
    // MARK: - Function to bind with ViewModel
    
    private func onBindingViewModel() {
        viewModel.onSetCalneder(to: .current)
        
        cancellable = viewModel.$calenderModel.sink(receiveValue: { model in
            if let calenderModel = model, let daysModel = model?.days {
                self.calenderDaysArray = daysModel
                self.calenderModel = calenderModel
                self.monthAndYear.text = calenderModel.monthAndYear
                if let todayString = calenderModel.today, let today = Int(todayString) {
                    self.selectedIndexPath = IndexPath(row: today-1, section: 0)
                } else {
                    self.selectedIndexPath = nil
                }
            }
        })
    }
    
    // MARK: - Change month when left and right arrow button tapped
    
    @IBAction func arrowTapped(_ sender: UIButton) {
        sender == rightBtn ? viewModel.onSetCalneder(to: .next) : viewModel.onSetCalneder(to: .previous)
    }
}

// MARK: - Calendar collection view delegate and datasource methods

extension CalendarView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return calenderDaysArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(DayCell.self, for: indexPath)
        let model = calenderDaysArray[indexPath.row]
        cell.isSelected = indexPath == selectedIndexPath ? true : false
        cell.updateCell(object: model)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model = calenderDaysArray[indexPath.row]
        delegate?.getSelectedDate(model.date)
    }
}

// MARK: - Add calendar to the view

extension CalendarView {
    public class func addCalendar(_ superView: UIView) -> CalendarView? {
        var calendarView: CalendarView?
        if calendarView == nil {
            calendarView = UINib(nibName: "CalendarView", bundle: nil).instantiate(withOwner: self, options: nil).last as? CalendarView
            guard let calenderView = calendarView else { return nil }
            calendarView?.frame = CGRect(x: 0, y: 0, width: superView.bounds.size.width, height: superView.bounds.size.height)
            superView.addSubview(calenderView)
            calenderView.initialize()
            return calenderView
        }
        return nil
    }
}
