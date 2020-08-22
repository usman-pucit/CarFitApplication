//
//  ViewController.swift
//  Calendar
//
//  Test Project
//

import Combine
import UIKit

// MARK: - Class ViewController

class HomeViewController: UIViewController, AlertDisplayer {
    // MARK: IBOutlets
    
    @IBOutlet var navBar: UINavigationBar!
    @IBOutlet var calendarView: UIView!
    @IBOutlet var calendar: UIView!
    @IBOutlet var calendarButton: UIBarButtonItem!
    @IBOutlet var workOrderTableView: UITableView!
    @IBOutlet var tableViewTopConstraint: NSLayoutConstraint!
    @IBOutlet var calenderViewHeight: NSLayoutConstraint!
    
    // MARK: Properties
    
    private var lastContentOffset: CGFloat = 0
    private var minHeaderHeight: CGFloat = 20.0
    private let maxHeaderHeight: CGFloat = 200
    private let tableViewTop: CGFloat = 112.0
    private var cancellables: [AnyCancellable] = []
    private var viewModel: CleanerListViewModel!
    
    // Refresh control for TableView
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(handleRefresh(_:)),
                                 for: UIControl.Event.valueChanged)
        refreshControl.tintColor = UIColor.gray
        return refreshControl
    }()
    
    // MARK: Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialize view model with required dependency of APIClientType
        self.viewModel = CleanerListViewModel(useCase: HomeListingUseCase())
        self.setupUI()
        self.bindViewModel()
    }
    
    // MARK: Life cycle
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.addCalendar()
    }
    
    // MARK: - UI setups
    
    private func setupUI() {
        self.navBar.transparentNavigationBar()
        self.navBar.topItem?.title = .homeScreenTitle
        self.workOrderTableView.registerNib(HomeTableViewCell.self)
        self.workOrderTableView.rowHeight = UITableView.automaticDimension
        self.workOrderTableView.estimatedRowHeight = 170
        self.workOrderTableView.addSubview(self.refreshControl)
    }
    
    // MARK: - Binding ViewModel
    
    private func bindViewModel() {
        // Fucntion call for mock request
        let jobSchedules = self.viewModel.jobSchedules(with: .mockFileName)
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()
        
        jobSchedules.sink(receiveValue: { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success:
                strongSelf.calendarButton.isEnabled = true
                strongSelf.workOrderTableView.reloadData()
            case .failure:
                strongSelf.calendarButton.isEnabled = false
                strongSelf.showError()
            }
        }).store(in: &cancellables)
    }
    
    // MARK: - Function to show error alert
    
    private func showError() {
        let action = UIAlertAction(title: .buttonOkText, style: .default)
        self.displayAlert(with: .errorTitle, message: self.viewModel.errorString ?? APIError.invalidResponse.rawValue, actions: [action])
    }
    
    // MARK: - Add calender to view
    
    private func addCalendar() {
        if let calendar = CalendarView.addCalendar(self.calendar) {
            calendar.delegate = self
        }
    }
    
    // MARK: - Function refresh controll
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        LogsManager.printLog("Reloading tableview with refresh control....")
        self.workOrderTableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    // MARK: - Show calendar when tapped, Hide the calendar when tapped outside the calendar view
    
    @IBAction func calendarTapped(_ sender: UIBarButtonItem) {
        self.calenderViewHeight.constant = maxHeaderHeight
        self.tableViewTopConstraint.constant = tableViewTop
        
        UIView.animate(withDuration: 0.4) {
            self.view.layoutIfNeeded()
        }
    }
}

// MARK: - Tableview delegate and datasource methods

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: HomeTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        let cellViewModel = viewModel[rowValue: indexPath.row]
        cell.updateCell(object: cellViewModel)
        return cell
    }
}

// MARK: - Extension

/// ScrollView Delegates

extension HomeViewController {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.lastContentOffset = scrollView.contentOffset.y
    }
    
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        self.calendarButton.isEnabled = false
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if self.lastContentOffset < scrollView.contentOffset.y, self.calenderViewHeight.constant > 0.0 {
            self.calenderViewHeight.constant = 0
            self.tableViewTopConstraint.constant = 0
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.calendarButton.isEnabled = true
    }
}

// MARK: - Get selected calendar date

extension HomeViewController: CalendarDelegate {
    func getSelectedDate(_ date: String) {
        LogsManager.printLog("Selected date: " + date)
    }
}
