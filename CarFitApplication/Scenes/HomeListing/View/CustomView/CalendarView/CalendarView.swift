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
    private var viewModel: CalenderViewModel!
    private var cancellables: [AnyCancellable] = []
    
    // MARK: - Initialize calendar
    
    private func initialize() {
        viewModel = CalenderViewModel()
        setupUI()
        bindViewModel(with: .current)
    }
    
    // MARK: - Function
    
    private func setupUI() {
        daysCollectionView.registerNib(DayCell.self)
        daysCollectionView.delegate = self
        daysCollectionView.dataSource = self
    }
    
    // MARK: - Function to bind with ViewModel
    
    private func bindViewModel(with selectedMonth: SelectedMonth) {
        let output = viewModel.setCalneder(to: selectedMonth)
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()
        
        output.sink(receiveValue: { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success:
                strongSelf.refreshCollectionView()
            case .failure:
                break
            }
        }).store(in: &cancellables)
    }
    
    // MARK: - Function to refresh data on calender change.
    
    private func refreshCollectionView() {
        monthAndYear.text = viewModel.monthAndYear
        daysCollectionView.reloadData()
        daysCollectionView.selectItem(at: viewModel.selectedIndexPath, animated: true, scrollPosition: .left)
        daysCollectionView.setNeedsLayout()
    }
    
    // MARK: - Change month when left and right arrow button tapped
    
    @IBAction func arrowTapped(_ sender: UIButton) {
        sender == rightBtn ? bindViewModel(with: .next) : bindViewModel(with: .previous)
    }
}

// MARK: - Delegate & Datasource

extension CalendarView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: DayCell = collectionView.dequeueReusableCell(for: indexPath)
        let cellViewModel = viewModel[rowValue: indexPath.row]
        cell.updateCell(object: cellViewModel)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cellViewModel = viewModel[rowValue: indexPath.row]
        delegate?.getSelectedDate(cellViewModel.date)
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
