//
//  CarFitApplicationTests.swift
//  CarFitApplicationTests
//
//  Created by Muhammad Usman on 07/08/2020.
//  Copyright © 2020 usman. All rights reserved.
//

@testable import CarFitApplication
import Combine
import XCTest

class CarFitApplicationTests: XCTestCase {
    var homeViewModel: HomeViewModel!
    var cancelablle: AnyCancellable!
    var ineractor: CarFitInteractor!
    let apiClient = MockApiClient<CFSchedulesResponseModel>()
    
    override func setUp() {
        homeViewModel = HomeViewModel(apiClient: apiClient)
    }
    
    override func tearDown() {
        homeViewModel = nil
        cancelablle = nil
        ineractor = nil
        super.tearDown()
    }
    
    // MARK: Test request function working properly
    
    // Test must pass and give response back
    func testRequestFromMock() {
        let expectation = XCTestExpectation(description: "Date fetched")
        
        cancelablle = homeViewModel?.$dataSource.sink(receiveValue: { response in
            if response != nil {
                expectation.fulfill()
            }
        })
        
        cancelablle = homeViewModel?.$error.sink(receiveValue: { error in
            if error != nil {
                XCTAssert(false, "Failed to fetch results")
            }
        })
        
        homeViewModel?.performRequestFromMock()
    }
    
    // MARK: Test request function giving proper error with Live environment.
    
    /// As live API envrionment is not added and its just available for enhancement option so request must fail over it.
    /// Test must fail and resturns an error.
    
    func testRequestFailureWithWrongEnvironment() {
        let expectation = XCTestExpectation(description: "Date fetched failed")
        
        homeViewModel = HomeViewModel(apiClient: APIClient())
        
        cancelablle = homeViewModel?.$dataSource.sink(receiveValue: { response in
            if response != nil {
                XCTAssert(false, "Failed to fetch results")
            }
        })
        
        cancelablle = homeViewModel?.$error.sink(receiveValue: { error in
            if error != nil {
                expectation.fulfill()
            }
        })
        
        homeViewModel?.performRequestFromMock()
    }
    
    // MARK: Test request function giving proper error with wrong file name.
    
    /// Test must fail and resturns an error.
    
    func testRequestFailureWithWrongFileName() {
        let expectation = XCTestExpectation(description: "Date fetched failed")
        
        cancelablle = homeViewModel?.$dataSource.sink(receiveValue: { response in
            if response != nil {
                XCTAssert(false, "Failed to fetch results")
            }
        })
        
        cancelablle = homeViewModel?.$error.sink(receiveValue: { error in
            if error != nil {
                expectation.fulfill()
            }
        })
        
        homeViewModel?.performRequestFromMock(fileName: "mock")
    }
    
    // MARK: Test request function giving proper error with wrong interactor environment
    
    /// Test must fail and resturns an error.
    
    func testRequestFailureWithWrongInteractorEnvironment() {
        let expectation = XCTestExpectation(description: "Date fetched failed")
        
        ineractor = CarFitInteractor(apiClient: APIClient())
        
        ineractor.performRequestFromMock(with: .mockFileName, onSuccess: { _ in
            XCTAssert(false, "Failed to fetch results")
        }) { _ in
            expectation.fulfill()
        }
    }
    
}
