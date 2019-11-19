//
//  VehiclesCollectionViewDataSourceTests.swift
//  TaxiAppTests
//
//  Created by Dipak V. Vyawahare on 19/11/19.
//  Copyright © 2019 MyOrganization. All rights reserved.
//

import XCTest
@testable import TaxiApp

class VehiclesCollectionViewDataSourceTests: XCTestCase {
    var sut: VehiclesCollectionViewDataSource!
    
    override func setUp() {
        super.setUp()
        sut = VehiclesCollectionViewDataSource()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testEmptyValueInDataSource() {
        sut.data.value = []
        
        let view = UICollectionView(frame: CGRect.zero,
                                    collectionViewLayout: UICollectionViewLayout.init())
        view.dataSource = sut
        
        XCTAssertEqual(sut.collectionView(view, numberOfItemsInSection: 0), 0,
                       "Expected 0 items in collection view")
    }
    
    private func createFromJSON(_ data: Data) -> [Vehicle] {
        guard let list = try? JSONDecoder().decode(POIList.self,
                                                   from: data) else {
                                                    return []
        }
        return list.poiList
    }
    
    func testValueInDataSource() {
        
        // giving a sample json file
        guard let data = FileManager.readJson(forResource: "sample",
                                              bundle: Bundle(for: VehiclesServiceTests.self))  else {
                                                XCTAssert(false, "Can't get data from sample.json")
                                                return
        }
        sut.data.value = createFromJSON(data)
        
        let view = UICollectionView(frame: CGRect.zero,
                                    collectionViewLayout: UICollectionViewLayout.init())
        view.dataSource = sut
        XCTAssertEqual(sut.collectionView(view, numberOfItemsInSection: 0),
                       17,
                       "Expected 17 items in collection view")
        
        view.register(VehicleCollectionViewCell.self,
                      forCellWithReuseIdentifier: "VehicleCollectionCellIdentifier")
        XCTAssertNotNil(sut.collectionView(view,
                                                  cellForItemAt: IndexPath(item: 0, section: 0)),
                        "Expected non nil")
    }
}
