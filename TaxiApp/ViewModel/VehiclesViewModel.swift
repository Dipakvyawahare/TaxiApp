//
//  VehicleViewModel.swift
//  TaxiApp
//
//  Created by Dipak V. Vyawahare on 19/11/19.
//  Copyright © 2019 MyOrganization. All rights reserved.
//

import Foundation

extension Location {
    static let initialPoint1 = Location(latitude: 53.694865,
                                        longitude: 9.757589)
    static let initialPoint2 = Location(latitude: 53.394655,
                                        longitude: 10.099891)
}

class VehiclesViewModel: NSObject {
    var dataSources: [VehiclesDataSource]?
    weak var service: VehicleServiceProtocol?
    
    @objc var onErrorHandling: ((ErrorResult?) -> Void)?
    
    init(service: VehicleServiceProtocol = VehicleService.shared,
         dataSources: [VehiclesDataSource]?) {
        self.dataSources = dataSources
        self.service = service
    }
    
    @objc init(dataSources: [VehiclesDataSource]?) {
        self.dataSources = dataSources
        self.service = VehicleService.shared
    }
    
    @objc func fetchVehicles() {
        fetchVehicles(point1: Location.initialPoint1,
                      point2: Location.initialPoint2)
    }
    
    func fetchVehicles(point1: Location,
                       point2: Location) {
        guard let service = service else {
            onErrorHandling?(ErrorResult(.custom, "Missing service"))
            return
        }
        service.fetchVehicles(from: point1,
                              to: point2) { (result) in
                                switch result {
                                case .success(let vehicles) :
                                    self.dataSources?.forEach({ (dataSource) in
                                        dataSource.data.value = vehicles ?? []
                                    })
                                case .failure(let error) :
                                    self.onErrorHandling?(error)
                                }
        }
    }
}
