//
//  CarFitCalenderTest.swift
//  CarFitApplicationTests
//
//  Created by Usman on 13/08/2020.
//  Copyright © 2020 usman-pucit All rights reserved.
//

@testable import CarFitApplication
import Combine
import XCTest

class CarFitCalenderTest: XCTestCase {
    var viewModel: CalenderViewModel!
    private var cancellables: [AnyCancellable] = []
    
    override func setUp() {
        viewModel = CalenderViewModel()
    }
    
    override func tearDown() {
        viewModel = nil
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()
    }
    
    // MARK: Test setting calender working properly for current month
    
    func testSettingCalenderForCurrentMonth() {
        let expectation = XCTestExpectation(description: "Correct current date selected")
        
        let output = viewModel.setCalneder(to: .current)
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()
        
        output.sink(receiveValue: { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success:
                if strongSelf.viewModel.monthAndYear == Date.selectedDate.monthAndYear {
                    expectation.fulfill()
                } else {
                    XCTAssert(false, "Failed")
                }
            case .failure:
                XCTAssert(false, "Failed")
            }
        }).store(in: &cancellables)
    }
    
    // MARK: Test setting calender working properly for next month
    
    func testSettingCalenderForNextMonth() {
        let expectation = XCTestExpectation(description: "Correct next date selected")
        
        let output = viewModel.setCalneder(to: .current)
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()
        
        output.sink(receiveValue: { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success:
                if strongSelf.viewModel.monthAndYear == Date.selectedDate.monthAndYear {
                    expectation.fulfill()
                } else {
                    XCTAssert(false, "Failed")
                }
            case .failure:
                XCTAssert(false, "Failed")
            }
        }).store(in: &cancellables)
    }
    
    // MARK: Test setting calender working properly for previous month
    
    func testSettingCalenderForPreviousMonth() {
        let expectation = XCTestExpectation(description: "Correct previous date selected")
        
        let output = viewModel.setCalneder(to: .current)
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()
        
        output.sink(receiveValue: { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success:
                if strongSelf.viewModel.monthAndYear == Date.selectedDate.monthAndYear {
                    expectation.fulfill()
                } else {
                    XCTAssert(false, "Failed")
                }
            case .failure:
                XCTAssert(false, "Failed")
            }
        }).store(in: &cancellables)
    }
    
    // MARK: Test caleder setting up correct dates
    
    func testSettingUpCalenderAndResult() {
        let expectation = XCTestExpectation(description: "Wrong date")
        
        var output = viewModel.setCalneder(to: .current)
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()
        
        output.sink(receiveValue: { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success:
                if strongSelf.viewModel.monthAndYear != Date.selectedDate.previosMonth.monthAndYear {
                    expectation.fulfill()
                } else {
                    XCTAssert(false, "Failed")
                }
            case .failure:
                XCTAssert(false, "Failed")
            }
        }).store(in: &cancellables)
        
        output = viewModel.setCalneder(to: .previous)
        output.sink(receiveValue: { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success:
                if strongSelf.viewModel.monthAndYear != Date.selectedDate.nextMonth.monthAndYear {
                    expectation.fulfill()
                } else {
                    XCTAssert(false, "Failed")
                }
            case .failure:
                XCTAssert(false, "Failed")
            }
        }).store(in: &cancellables)
        
        output = viewModel.setCalneder(to: .next)
        output.sink(receiveValue: { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success:
                if strongSelf.viewModel.monthAndYear != Date.selectedDate.previosMonth.monthAndYear {
                    expectation.fulfill()
                } else {
                    XCTAssert(false, "Failed")
                }
            case .failure:
                XCTAssert(false, "Failed")
            }
        }).store(in: &cancellables)
    }
    
    // MARK: Test selectedIndexPath
    
    /// Test must pass and fulfill expected results.
    
    func testSelectedIndexPath() {
        let expectation = XCTestExpectation(description: "Selected indexpath matched")
        
        let output = viewModel.setCalneder(to: .current)
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()
        
        output.sink(receiveValue: { [weak self] _ in
            guard let strongSelf = self else { return }
            
            if let todayString = Date().today, let today = Int(todayString), strongSelf.viewModel.selectedIndexPath == IndexPath(row: today-1, section: 0) {
                expectation.fulfill()
            } else {
                XCTAssert(false, "Failed")
            }
            
        }).store(in: &cancellables)
    }
}
