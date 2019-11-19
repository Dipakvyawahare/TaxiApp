//
//  RequestServiceTests.swift
//  TaxiAppTests
//
//  Created by Dipak V. Vyawahare on 19/11/19.
//  Copyright © 2019 MyOrganization. All rights reserved.
//

import XCTest
@testable import TaxiApp

class RequestServiceTests: XCTestCase {
    var sut: RequestService?
    var session: MockUrlSession?
    
    override func setUp() {
        super.setUp()
        sut = RequestService()
        session = MockUrlSession()
        sut?.session = session!
    }
    
    override func tearDown() {
        sut = nil
        session = nil
        super.tearDown()
    }

    func testServiceFailure() {
        session?.error = NSError(domain: "",
                                 code: 0, 
                                 userInfo: nil)
        sut?.fetchData(using: [:], completion: { (result) in
            switch result {
            case .success:
                XCTAssert(false, "Expected failure")
            default:
                break
            }
        })
    }
    
    func testServiceSuccess() {
        session?.error = nil
        session?.data = Data()
        sut?.fetchData(using: [:], completion: { (result) in
            switch result {
            case .failure:
                XCTAssert(false, "Expected Success")
            default:
                break
            }
        })
    }
}

class MockUrlSession: URLSession {
    var data: Data?
    var error: Error?
    override func dataTask(with request: URLRequest,
                           completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        completionHandler(data, nil, error)
        return MockTask()
    }
}

class MockTask: URLSessionDataTask {
    override func resume() {
        
    }
}
