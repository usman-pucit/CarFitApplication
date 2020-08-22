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
    var viewModel: HomeViewModel!
    var cancellables: [AnyCancellable] = []
    var useCase: CarFitUseCaseType!
    
    override func setUp() {
        viewModel = HomeViewModel(useCase: HomeListingUseCase())
        useCase = HomeListingUseCase(apiClient: MockApiClient())
    }
    
    override func tearDown() {
        viewModel = nil
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()
        super.tearDown()
    }
    
    // MARK: Test request function working properly
    
    // Test must pass and give response back
    func testRequestFromMock() {
        let expectation = XCTestExpectation(description: "Date fetched")
        
        let results = useCase.jobSchedules(with: .mockFileName)
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()
        
        results.sink(receiveValue: { [weak self] result in
            guard self != nil else { return }
            switch result {
            case .success:
                expectation.fulfill()
            case .failure:
                XCTAssert(false, "Failed to fetch results")
            }
        }).store(in: &cancellables)
    }
    
    // MARK: Test request function giving proper error with wrong file name.
    
    /// Test must fail and resturns an error.
    
    func testRequestFailureWithWrongFileName() {
        let expectation = XCTestExpectation(description: "Date fetched failed")
        
        let results = useCase.jobSchedules(with: "Test")
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()
        
        results.sink(receiveValue: { [weak self] result in
            guard self != nil else { return }
            switch result {
            case .success:
                XCTAssert(false, "Failed to fetch results")
            case .failure:
                expectation.fulfill()
            }
        }).store(in: &cancellables)
    }
    
    // MARK: Test request function giving proper error with wrong file name.
    
    /// Test must pass and fulfill expected results.
    
    func testMockRequestHandler() {
        let expectation = XCTestExpectation(description: "Request handler working properly")
        
        let results = viewModel.jobSchedules(with: .mockFileName)
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()
        
        results.sink(receiveValue: { result in
            switch result {
            case .success:
                expectation.fulfill()
            case .failure:
                XCTAssert(false, "Failed to fetch results")
            }
        }).store(in: &cancellables)
    }
    
    // MARK: Test error message
    
    /// Test error message is properly set
    
    func testErrorMessage() {
        let expectation = XCTestExpectation(description: "Request handler working properly")
        
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()
        
        _ = viewModel.jobSchedules(with: "")
            .map({ (result) -> CFResult<[HomeTableViewCellModel]> in
                
                switch result {
                case .success(let jobs):
                    XCTAssert(false, "Failed to fetch results")
                    return .success(jobs)
                case .failure(let error):
                    if error.rawValue == APIError.invalidResponse.rawValue {
                        expectation.fulfill()
                    } else {
                        XCTAssert(false, "Failed to fetch results")
                    }
                    
                    return .failure(error)
                }
            }).eraseToAnyPublisher()
    }
}
