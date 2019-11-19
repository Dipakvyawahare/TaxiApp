//
//  UIImageExtensionsTests.swift
//  TaxiAppTests
//
//  Created by Dipak V. Vyawahare on 18/11/19.
//  Copyright © 2019 MyOrganization. All rights reserved.
//

import XCTest
@testable import TaxiApp

class UIImageExtensionsTests: XCTestCase {
    var image: UIImage?
    
    override func setUp() {
        image = UIImage(named: "taxi")
    }

    override func tearDown() {
        image = nil
    }

    func testRotatedByAngle() {
        if let image = image {
            let halfRotatedImage = image.rotated(by: 90)
            XCTAssertNotNil(halfRotatedImage)
            XCTAssertEqual(halfRotatedImage!.size,
                           CGSize(width: image.size.height.rounded(),
                                  height: image.size.width.rounded()))
            let rotatedImage = image.rotated(by: 180)
            XCTAssertNotNil(rotatedImage)
        }
    }
}
