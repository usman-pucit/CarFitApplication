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
    var homeUseCase : HomeListingUseCase!
    var apiClient : MockApiClient!
    
    override func setUp() {
        apiClient = MockApiClient()
        homeViewModel = HomeViewModel(apiClient: apiClient)
        homeUseCase = HomeListingUseCase(apiClient: MockApiClient())
    }
    
    override func tearDown() {
        apiClient = nil
        homeViewModel = nil
        cancelablle = nil
        homeUseCase = nil
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
        
        homeViewModel?.performRequestWithMock()
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
        
        homeViewModel?.performRequestWithMock(fileName: "mock")
    }
    
    // MARK: Test request function giving proper error with wrong file name.
    
    /// Test must pass and fulfill expected results.
    
    func testMockRequestHandler() {
        let expectation = XCTestExpectation(description: "Request handler working properly")
        
        homeUseCase.performRequestWithMock(with: .mockFileName) { [weak self] result in
            guard self != nil else { return }
            switch result {
            case .success(_):
               expectation.fulfill()
            case .failure(_):
                XCTAssert(false, "Failed to fetch results")
            }
        }
        
    }
    
}
