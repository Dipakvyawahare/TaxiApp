//
//  VehicleService.swift
//  TaxiApp
//
//  Created by Dipak V. Vyawahare on 19/11/19.
//  Copyright © 2019 MyOrganization. All rights reserved.
//

import Foundation

protocol VehicleServiceProtocol: class {
    func fetchVehicles(from point1: Location,
                       to point2: Location,
                       _ completion: @escaping ((Result<[Vehicle]?, ErrorResult>) -> Void))
    func cancelFetchVehicles()
}

class POIList: Decodable {
    let poiList: [Vehicle]
}

final class VehicleService: VehicleServiceProtocol, DataParser {
    static let shared = VehicleService()
    weak var task: URLSessionDataTask?
    var requestService: RequestServiceProtocol? = RequestService.shared
    
    func fetchVehicles(from point1: Location,
                       to point2: Location,
                       _ completion: @escaping ((Result<[Vehicle]?, ErrorResult>) -> Void)) {
        let params = ["p1Lat": String(point1.latitude),
                      "p1Lon": String(point1.longitude),
                      "p2Lat": String(point2.latitude),
                      "p2Lon": String(point2.longitude)]
        
        //Cancel previous request if any
        cancelFetchVehicles()
        
        task = requestService?.fetchData(using: params) { [weak self] (result) in
            switch result {
            case .success(let data):
                if let parsed: Result<POIList, ErrorResult> = self?.parse(data: data) {
                    switch parsed {
                    case .success(let poi):
                        completion(.success(poi.poiList))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func cancelFetchVehicles() {
        if let task = task {
            task.cancel()
        }
        task = nil
    }
}
