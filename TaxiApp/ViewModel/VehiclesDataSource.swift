//
//  VehiclesDataSource.swift
//  TaxiApp
//
//  Created by Dipak V. Vyawahare on 19/11/19.
//  Copyright © 2019 MyOrganization. All rights reserved.
//

import Foundation

@objc protocol VehiclesDataSource {
    var data: VehicleObserver {get set}
}
