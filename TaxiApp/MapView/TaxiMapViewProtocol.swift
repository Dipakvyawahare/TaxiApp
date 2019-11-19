//
//  TaxiMapViewProtocol.swift
//  TaxiApp
//
//  Created by Dipak V. Vyawahare on 18/11/19.
//  Copyright © 2019 MyOrganization. All rights reserved.
//

import Foundation

@objc protocol TaxiMapViewProtocol {
    func visibleRegionChanged(to point1: Location, from point2: Location)
}
