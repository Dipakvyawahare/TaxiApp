//
//  Result.swift
//  TaxiApp
//
//  Created by Dipak V. Vyawahare on 18/11/19.
//  Copyright © 2019 MyOrganization. All rights reserved.
//

import Foundation

enum Result<T, E: Error> {
    case success(T)
    case failure(E)
}
