//
//  VehiclesTests.swift
//  TaxiAppTests
//
//  Created by Dipak V. Vyawahare on 19/11/19.
//  Copyright © 2019 MyOrganization. All rights reserved.
//

import XCTest
@testable import TaxiApp

class VehiclesServiceTests: XCTestCase {
    var sut: VehicleService?
    var requestService: MockRequestService?
    
    override func setUp() {
        super.setUp()
        sut = VehicleService()
        requestService = MockRequestService()
        sut?.requestService = requestService
    }
    
    override func tearDown() {
        sut = nil
        requestService = nil
        super.tearDown()
    }

    func testParseEmptyVehicles() {
        
        // giving empty data
        requestService?.data = Data()
        sut?.fetchVehicles(from: Location.initialPoint1,
                                       to: Location.initialPoint2) { (result) in
            switch result {
            case .success:
                XCTAssert(false, "Expected failure when no data")
            default:
                break
            }
        }
    }
    
    func testParseVehicles() {
        
        // giving a sample json file
        guard let data = FileManager.readJson(forResource: "sample",
                                              bundle: Bundle(for: VehiclesServiceTests.self))  else {
                                                XCTAssert(false, "Can't get data from sample.json")
                                                return
        }
        requestService?.data = data
        // giving completion after parsing
        // expected valid vehicles with valid data
        sut?.fetchVehicles(from: Location.initialPoint1,
                               to: Location.initialPoint2) { (result) in
                                switch result {
                                case .failure:
                                    XCTAssert(false, "Expected valid vehicle")
                                case .success(let vehicles):
                                    if let vehicles = vehicles {
                                        let vehicle = vehicles[0]
                                        XCTAssertEqual(vehicles.count,
                                                       17,
                                                       "Parsing error or sample.json content")
                                        XCTAssertEqual(vehicle.id,
                                                       367716,
                                                       "Expected 367716")
                                        XCTAssertEqual(vehicle.fleetType,
                                                       FleetType.pooling,
                                                       "Expected pooling")
                                        XCTAssertEqual(vehicle.heading,
                                                       223.02207553870448,
                                                       "Expected 223.02207553870448")
                                        XCTAssertEqual(vehicle.coordinate.latitude,
                                                       53.57718597913445,
                                                       "Expected 53.57718597913445")
                                        XCTAssertEqual(vehicle.coordinate.longitude,
                                                       10.073238712722642,
                                                       "Expected 10.073238712722642")
                                    }
                                }
        }
    }
}

class MockRequestService: RequestServiceProtocol {
    var data: Data?
    func fetchData(using params: [String: String],
                   completion: @escaping ((Result<Data, ErrorResult>) -> Void)) -> URLSessionDataTask? {
        if let data = data {
             completion(.success(data))
        } else {
            completion(.failure(ErrorResult(.custom, "No data")))
        }
        return nil
    }
}
