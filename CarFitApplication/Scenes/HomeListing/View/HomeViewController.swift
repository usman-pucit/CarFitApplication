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
    private var viewModel: HomeViewModel!
    private var cancellable: AnyCancellable?
    private var dataSource: CFSchedulesResponseModel? {
        didSet {
            self.workOrderTableView.reloadData()
        }
    }
    
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
        
        // Initialize view model with required dependency of APIClientProtocol
        self.viewModel = HomeViewModel(apiClient: MockApiClient())
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
    
    // MARK: - Function for to bind ViewModel
    
    private func bindViewModel() {
        // Fucntion call for mock request
        self.viewModel.performRequestWithMock()
        
        // Subscription of datasource
        self.cancellable = self.viewModel.$dataSource.sink(receiveValue: { value in
            self.dataSource = value
        })
        
        // Subscription of error
        self.cancellable = self.viewModel.$error.sink(receiveValue: { error in
            guard let _error = error else { return }
            let action = UIAlertAction(title: .buttonOkText, style: .default) { _ in
            }
            DispatchQueue.main.async {
                self.displayAlert(with: .errorTitle, message: _error.rawValue, actions: [action])
            }
        })
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
        return self.dataSource?.data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(HomeTableViewCell.self, for: indexPath)
        let object = dataSource?.data?[indexPath.row]
        
        cell.updateCell(object: object!)
        return cell
    }
}

// MARK: - Extension for Scrolling delegates

extension HomeViewController {
    // MARK: - Function this delegate is called when start scrolling
    
    // Disable calendarButton while scrolling
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.lastContentOffset = scrollView.contentOffset.y
        self.calendarButton.isEnabled = false
    }
    
    // MARK: - Function this scrolling this delegate is being called so you may now check direction
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if self.lastContentOffset < scrollView.contentOffset.y, self.calenderViewHeight.constant > 0.0 {
            self.calenderViewHeight.constant = 0
            self.tableViewTopConstraint.constant = 0
        }
    }
    
    // MARK: - Function this delegate is called on scrolling ended
    
    // Enable calendarButton after scrolling is ended
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
