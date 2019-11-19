//
//  URLExtensionsTests.swift
//  TaxiAppTests
//
//  Created by Dipak V. Vyawahare on 19/11/19.
//  Copyright © 2019 MyOrganization. All rights reserved.
//

import XCTest
@testable import TaxiApp

class URLExtensionsTests: XCTestCase {

    var url = URL(string: "https://www.mysite.com")!
    let params = ["query1": "hitMyfunction"]
    let queryUrl = URL(string: "https://www.mysite.com?query1=hitMyfunction")!
    
    func testAppendingQueryParameters() {
        XCTAssertEqual(url.appendParameters(params: params), queryUrl)
    }
}
