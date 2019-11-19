//
//  VehiclePointAnnotation.swift
//  TaxiApp
//
//  Created by Dipak V. Vyawahare on 18/11/19.
//  Copyright © 2019 MyOrganization. All rights reserved.
//

import MapKit

class VehiclePointAnnotation: MKPointAnnotation {
    var vehicle: Vehicle
    init(vehicle: Vehicle) {
        self.vehicle = vehicle
    }
}
