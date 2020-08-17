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
    
    var calenderVM = CalenderViewModel()
    var cancelablle: AnyCancellable!
    
    override class func setUp() {
        
    }
    
    override func tearDown() {
        
    }
    
    // MARK: Test setting calender working properly for current month

    func testSettingCalenderForCurrentMonth() {
        let expectation = XCTestExpectation(description: "Correct date selected")
        
        calenderVM.onSetCalneder(to: .current)
        cancelablle = calenderVM.$calenderModel.sink(receiveValue: { (model) in
            if model?.today == Date().today{
                expectation.fulfill()
            }else{
                 XCTAssert(false, "Failed")
            }
        })
    
    }
    
    // MARK: Test setting calender working properly for next month

    func testSettingCalenderForNextMonth() {
        let expectation = XCTestExpectation(description: "Correct date selected")
        
        calenderVM.onSetCalneder(to: .next)
        cancelablle = calenderVM.$calenderModel.sink(receiveValue: { (model) in
            if model?.monthAndYear == Date().nextMonth.monthAndYear{
                expectation.fulfill()
            }else{
                 XCTAssert(false, "Failed")
            }
        })
    
    }
    
    // MARK: Test setting calender working properly for previous month

    func testSettingCalenderForPreviousMonth() {
        let expectation = XCTestExpectation(description: "Correct date selected")
        
        calenderVM.onSetCalneder(to: .next)
        cancelablle = calenderVM.$calenderModel.sink(receiveValue: { (model) in
            if model?.monthAndYear == Date().previosMonth.monthAndYear{
                expectation.fulfill()
            }else{
                 XCTAssert(false, "Failed")
            }
        })
    
    }
    
}
