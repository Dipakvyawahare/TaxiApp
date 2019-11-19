//
//  Location.swift
//  TaxiApp
//
//  Created by Dipak V. Vyawahare on 18/11/19.
//  Copyright © 2019 MyOrganization. All rights reserved.
//

import Foundation

@objcMembers
@objc class Location: NSObject, Decodable {
    let latitude: Double
    let longitude: Double
    
    init(latitude: Double,
         longitude: Double) {
        self.longitude = longitude
        self.latitude = latitude
    }
}
