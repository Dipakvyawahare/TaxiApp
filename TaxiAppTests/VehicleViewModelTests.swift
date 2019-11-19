//
//  VehicleViewModelTests.swift
//  TaxiAppTests
//
//  Created by Dipak V. Vyawahare on 19/11/19.
//  Copyright © 2019 MyOrganization. All rights reserved.
//

import XCTest
@testable import TaxiApp

class VehicleViewModelTests: XCTestCase {

    var viewModel: VehiclesViewModel!
    var dataSource: VehiclesDataSource!
    fileprivate var service: MockVehicleService!
    
    override func setUp() {
        super.setUp()
        service = MockVehicleService()
        dataSource = MockVehiclesDataSource()
        viewModel = VehiclesViewModel(service: service,
                                      dataSources: [dataSource])
    }

    override func tearDown() {
        service = nil
        dataSource = nil
        viewModel = nil
        super.tearDown()
    }
    
    func testFetchWithNoService() {
        
        let expectation = XCTestExpectation(description: "No service vehicle")
        
        // giving no service to a view model
        viewModel.service = nil
        
        // expected to not be able to fetch vehicles
        viewModel.onErrorHandling = { error in
            expectation.fulfill()
        }
        
        viewModel.fetchVehicles()
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testFetchNoVehicles() {
        let expectation = XCTestExpectation(description: "No Vehicles")
        
        // giving a service mocking error during fetching vehicles
        service.vehicles = nil
        
        // expected completion to fail
        viewModel.onErrorHandling = { error in
            expectation.fulfill()
        }
        
        viewModel.fetchVehicles()
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testFetchVehicles() {
        
        let expectation = XCTestExpectation(description: "Vehicle fetch")
        
        // giving a service mocking
        service.vehicles = []
        
        viewModel.onErrorHandling = { _ in
            XCTAssert(false, "ViewModel should not be able to fetch without service")
        }
        
        dataSource.data.addObserver(self) {
            expectation.fulfill()
        }
        
        viewModel.fetchVehicles()
        wait(for: [expectation], timeout: 5.0)
    }
}

class MockVehiclesDataSource: VehiclesDataSource {
    var data: VehicleObserver = VehicleObserver([])
}

class MockVehicleService: VehicleServiceProtocol {
    var vehicles: [Vehicle]?
    
    func fetchVehicles(from point1: Location,
                       to point2: Location,
                       _ completion: @escaping ((Result<[Vehicle]?, ErrorResult>) -> Void)) {
        if let vehicles = vehicles {
            completion(Result.success(vehicles))
        } else {
            completion(Result.failure(ErrorResult(.custom, "No Vehicles")))
        }
    }
    
    func cancelFetchVehicles() {
        
    }
}
