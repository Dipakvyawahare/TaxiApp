//
//  Vehicle.swift
//  TaxiApp
//
//  Created by Dipak V. Vyawahare on 18/11/19.
//  Copyright © 2019 MyOrganization. All rights reserved.
//

import UIKit

enum FleetType: String, Decodable {
    case taxi = "TAXI"
    case pooling = "POOLING"
}

class Vehicle: NSObject, Decodable {
    let id: Int
    let coordinate: Location
    let fleetType: FleetType
    let heading: Double
}
