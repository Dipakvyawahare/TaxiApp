//
//  VehicleMapViewDelegateTests.swift
//  TaxiAppTests
//
//  Created by Dipak V. Vyawahare on 19/11/19.
//  Copyright © 2019 MyOrganization. All rights reserved.
//

import XCTest
@testable import TaxiApp
import MapKit

class VehicleMapViewDelegateTests: XCTestCase {
    var sut: VehicleMapViewDelegate?
    fileprivate var mockTaxiMap: MockTaxiMapSpy?
    
    override func setUp() {
        super.setUp()
        sut = VehicleMapViewDelegate()
        mockTaxiMap = MockTaxiMapSpy()
        sut?.delegate = mockTaxiMap
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    private func createFromJSON(_ data: Data) -> Vehicle? {
        guard let list = try? JSONDecoder().decode(POIList.self,
                                                   from: data) else {
                                                    return nil
        }
        return list.poiList.first
    }
    
    func testDelegates() {
        guard let data = FileManager.readJson(forResource: "sample",
                                              bundle: Bundle(for: VehiclesServiceTests.self))  else {
                                                XCTAssert(false, "Can't get data from sample.json")
                                                return
        }
        let view = MapView()
        let vehicleAnnotation = VehiclePointAnnotation(vehicle: createFromJSON(data)!)
        XCTAssertNotNil(sut?.mapView(view.mapView, viewFor: vehicleAnnotation),
                        "Error in Vehicle Point annotation")
        
        let annotation = MKPointAnnotation()
        XCTAssertNotNil(sut?.mapView(view.mapView, viewFor: annotation),
                        "Error in Point annotation")
        
        let polyOverlay = MKPolygon(coordinates: [CLLocationCoordinate2DMake(3, 3)], count: 1)
        XCTAssertNotNil(sut?.mapView(view.mapView, rendererFor: polyOverlay),
                        "Error in Polygon renderer")
    }
    
    func testRegionChanged() {
        let view = MapView()
        sut?.mapView(view.mapView,
                     regionDidChangeAnimated: false)
        XCTAssertEqual(mockTaxiMap?.regionChanged,
                       true,
                       "Error in regionDidChangeAnimated")
    }
}

private class MockTaxiMapSpy: TaxiMapViewProtocol {
    var regionChanged = false
    func visibleRegionChanged(to point1: Location,
                              from point2: Location) {
        regionChanged = true
    }
}
