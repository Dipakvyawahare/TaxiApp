//
//  VehiclesMapDataSourceTests.swift
//  TaxiAppTests
//
//  Created by Dipak V. Vyawahare on 19/11/19.
//  Copyright © 2019 MyOrganization. All rights reserved.
//

import XCTest
import MapKit
@testable import TaxiApp

class VehiclesMapDataSourceTests: XCTestCase {
    var sut: VehiclesMapDataSource!
    
    override func setUp() {
        super.setUp()
        sut = VehiclesMapDataSource()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    private func createFromJSON(_ data: Data) -> [Vehicle] {
        guard let list = try? JSONDecoder().decode(POIList.self,
                                                   from: data) else {
                                                    return []
        }
        return list.poiList
    }
    
    func testEmptyValueInDataSource() {
        
        // giving empty data value
        sut.data.value = []
        
        let view = MockMapViewSpy()
        view.dataSource = sut
        
        sut.addAnnotations(view)
        XCTAssertEqual(view.addAnnotationCalled, false, "Error in addAnnotations")
        
        sut.drawOverlay(view)
        XCTAssertEqual(view.addOverlayCalled, true, "Error in drawOverlay")
        
        sut.resetFocus(view)
        XCTAssertEqual(view.resetFocusCalled, true, "Error in resetFocus")
        
        sut.selectAnnotation(view, at: 0)
        XCTAssertEqual(view.selectAnnotCalled, false, "Error in selectAnnotation")
    }
    
    func testValueInDataSource() {
        
        // giving a sample json file
        guard let data = FileManager.readJson(forResource: "sample",
                                              bundle: Bundle(for: VehiclesServiceTests.self)) else {
                                                XCTAssert(false, "Can't get data from sample.json")
                                                return
        }
        sut.data.value = createFromJSON(data)
        
        let view = MockMapViewSpy()
        view.dataSource = sut
        
        sut.addAnnotations(view)
        XCTAssertEqual(view.addAnnotationCalled, true, "Error in addAnnotations")
        
        sut.drawOverlay(view)
        XCTAssertEqual(view.addOverlayCalled, true, "Error in drawOverlay")
        
        sut.resetFocus(view)
        XCTAssertEqual(view.resetFocusCalled, true, "Error in resetFocus")
        
        sut.selectAnnotation(view, at: 0)
        XCTAssertEqual(view.selectAnnotCalled, false, "Error in selectAnnotation")
    }
}

class MockMapViewSpy: MapView {
    var addOverlayCalled = false
    var resetFocusCalled = false
    var selectAnnotCalled = false
    var addAnnotationCalled = false
    
    override func addAnnotation(_ annotation: MKAnnotation) {
        addAnnotationCalled = true
    }
    
    override func addOverlay(_ overlay: MKOverlay) {
        addOverlayCalled = true
    }
    
    override func selectAnnotation(at index: Int) {
        selectAnnotCalled = true
    }
    
    override func setVisibleMapRect(_ mapRect: MKMapRect,
                                    edgePadding insets: UIEdgeInsets,
                                    animated animate: Bool) {
        resetFocusCalled = true
    }
}
