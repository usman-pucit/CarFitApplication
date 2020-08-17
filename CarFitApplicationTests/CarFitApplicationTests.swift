//
//  CarFitApplicationTests.swift
//  CarFitApplicationTests
//
//  Created by Usman on 07/08/2020.
//  Copyright © 2020 usman-pucit All rights reserved.
//

@testable import CarFitApplication
import Combine
import XCTest

class CarFitApplicationTests: XCTestCase {
    var homeViewModel: HomeViewModel!
    var cancelablle: AnyCancellable!
    var interactor = CarFitInteractor(apiClient: MockApiClient())
    let apiClient = MockApiClient()
    
    override func setUp() {
        homeViewModel = HomeViewModel(apiClient: apiClient)
        interactor = CarFitInteractor(apiClient: apiClient)
    }
    
    override func tearDown() {
        homeViewModel = nil
        cancelablle = nil
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
    
}
