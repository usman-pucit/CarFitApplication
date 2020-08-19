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
    
    var calenderVM : CalenderViewModel!
    var cancelablle: AnyCancellable!
    
    override func setUp() {
        calenderVM = CalenderViewModel()
    }
    
    override func tearDown() {
        cancelablle = nil
        calenderVM = nil
    }
    
    // MARK: Test setting calender working properly for current month

    func testSettingCalenderForCurrentMonth() {
        let expectation = XCTestExpectation(description: "Correct current date selected")
        
        calenderVM.onSetCalneder(to: .current)
        cancelablle = calenderVM.$calenderModel.sink(receiveValue: { (model) in
            if model?.monthAndYear == Date.selectedDate.monthAndYear{
                expectation.fulfill()
            }else{
                 XCTAssert(false, "Failed")
            }
        })
    
    }
    
    // MARK: Test setting calender working properly for next month

    func testSettingCalenderForNextMonth() {
        let expectation = XCTestExpectation(description: "Correct next date selected")
        
        calenderVM.onSetCalneder(to: .next)
        cancelablle = calenderVM.$calenderModel.sink(receiveValue: { (model) in
            if model?.monthAndYear == Date.selectedDate.monthAndYear{
                expectation.fulfill()
            }else{
                 XCTAssert(false, "Failed")
            }
        })
    
    }
    
    // MARK: Test setting calender working properly for previous month

    func testSettingCalenderForPreviousMonth() {
        let expectation = XCTestExpectation(description: "Correct previous date selected")
        
        calenderVM.onSetCalneder(to: .previous)
        cancelablle = calenderVM.$calenderModel.sink(receiveValue: { (model) in
            if model?.monthAndYear == Date.selectedDate.monthAndYear{
                expectation.fulfill()
            }else{
                 XCTAssert(false, "Failed")
            }
        })

    }
    
    
    // MARK: Test caleder setting up correct dates

    func testSettingUpCalenderAndResult() {
        let expectation = XCTestExpectation(description: "Wrong date")
        
        calenderVM.onSetCalneder(to: .current)
        cancelablle = calenderVM.$calenderModel.sink(receiveValue: { (model) in
            if model?.monthAndYear != Date.selectedDate.previosMonth.monthAndYear{
                expectation.fulfill()
            }else{
                 XCTAssert(false, "Failed")
            }
        })
        
        calenderVM.onSetCalneder(to: .next)
        cancelablle = calenderVM.$calenderModel.sink(receiveValue: { (model) in
            if model?.monthAndYear != Date.selectedDate.previosMonth.monthAndYear{
                expectation.fulfill()
            }else{
                 XCTAssert(false, "Failed")
            }
        })
        
        calenderVM.onSetCalneder(to: .previous)
        cancelablle = calenderVM.$calenderModel.sink(receiveValue: { (model) in
            if model?.monthAndYear != Date.selectedDate.nextMonth.monthAndYear{
                expectation.fulfill()
            }else{
                 XCTAssert(false, "Failed")
            }
        })

    }
    
}
