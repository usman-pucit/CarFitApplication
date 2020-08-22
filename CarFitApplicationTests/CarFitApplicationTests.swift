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
    var viewModel: CleanerListViewModel!
    var cancellables: [AnyCancellable] = []
    var useCase: CarFitUseCaseType!
    
    override func setUp() {
        useCase = HomeListingUseCase(apiClient: MockApiClient())
        viewModel = CleanerListViewModel(useCase: useCase)
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    // MARK: Test request function working properly
    
    // Test must pass and give response back
    func testRequestFromMock() {
        let expectation = XCTestExpectation(description: "Date fetched")
        
        let results = viewModel.jobSchedules(with: .mockFileName)
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()
        
        results.sink(receiveValue: { [weak self] result in
            guard self != nil else { return }
            switch result {
            case .success:
                expectation.fulfill()
            case .failure:
                XCTAssert(false, "Failed")
            }
        }).store(in: &cancellables)
    }
    
    // MARK: Test request function giving proper error with wrong file name.
    
    /// Test must fail and resturns an error.
    
    func testRequestFailureWithWrongFileName() {
        let expectation = XCTestExpectation(description: "Date fetched failed")
        
        let results = viewModel.jobSchedules(with: "Test")
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()
        
        results.sink(receiveValue: { [weak self] result in
            guard self != nil else { return }
            switch result {
            case .success:
                XCTAssert(false, "Failed")
            case .failure:
                expectation.fulfill()
            }
        }).store(in: &cancellables)
    }
    
    // MARK: Test request handler
    
    /// Test must pass and fulfill expected results.
    
    func testMockRequestHandler() {
        let expectation = XCTestExpectation(description: "Request handler working properly")
        
        let results = useCase.jobSchedules(with: .mockFileName)
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()
        
        results.sink(receiveValue: { result in
            switch result {
            case .success:
                expectation.fulfill()
            case .failure:
                XCTAssert(false, "Failed")
            }
        }).store(in: &cancellables)
    }
    
    // MARK: Test error message
    
    /// Test error message is properly set
    
    func testErrorMessage() {
        let expectation = XCTestExpectation(description: "Error message is properly set")
        
        let viewModel = CleanerListViewModel(useCase: HomeListingUseCase())
        let results = viewModel.jobSchedules(with: "Wrong name")
        
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()
        
        results.sink(receiveValue: { result in
            
            switch result {
            case .success:
                XCTAssert(false, "Failed")
            case .failure:
                if let errorMessage = viewModel.errorString, errorMessage == APIError.invalidResponse.rawValue {
                    expectation.fulfill()
                } else {
                    XCTAssert(false, "Failed")
                }
            }
        }).store(in: &cancellables)
    }
    
    // MARK: Test number of rows
    
    /// Match number of rows with results
    
    func testNumberOfRows() {
        let expectation = XCTestExpectation(description: "Number of rows are equal")
        
        let viewModel = CleanerListViewModel(useCase: HomeListingUseCase())
        let results = viewModel.jobSchedules(with: .mockFileName)
        
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()
        
        results.sink(receiveValue: { result in
            
            switch result {
            case .success(let jobs):
                if jobs.count == viewModel.numberOfRows {
                    expectation.fulfill()
                } else {
                    XCTAssert(false, "Failed")
                }
            case .failure:
                XCTAssert(false, "Failed")
            }
        }).store(in: &cancellables)
    }
}
