//
//  VehicleDataSource.swift
//  TaxiApp
//
//  Created by Dipak V. Vyawahare on 19/11/19.
//  Copyright © 2019 MyOrganization. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class VehiclesMapDataSource: NSObject, VehiclesDataSource, MapViewDataSource {
    var data: VehicleObserver = VehicleObserver([])
    private weak var previousPinAnnotation: MKPointAnnotation?
    
    func addAnnotations(_ mapView: MapView) {
        for item in data.value {
            add(vehicle: item, to: mapView)
        }
    }
    
    func drawOverlay(_ mapView: MapView) {
        mapView.addOverlay(getRectangle(location1: Location.initialPoint1,
                                        location2: Location.initialPoint2))
    }
    
    func resetFocus(_ mapView: MapView) {
        let mapEdgePadding = UIEdgeInsets(top: 20,
                                          left: 20,
                                          bottom: 20,
                                          right: 20)
        let rect = getRectangle(location1: Location.initialPoint1,
                                location2: Location.initialPoint2).boundingMapRect
        mapView.setVisibleMapRect(rect,
                                  edgePadding: mapEdgePadding,
                                  animated: true)
    }
    
    func selectAnnotation(_ mapView: MapView,
                          at index: Int) {
        if let pin = previousPinAnnotation {
             mapView.removeAnnotation(annotation: pin)
        }
        if data.value.count > index {
            let vehicle = data.value[index]
            let location = vehicle.coordinate
            let clLocation = CLLocationCoordinate2D(latitude: location.latitude,
                                                    longitude: location.longitude)
            let annotation = MKPointAnnotation()
            annotation.coordinate = clLocation
            previousPinAnnotation = annotation
            mapView.setCenter(clLocation, animated: true)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                mapView.addAnnotation(annotation)
            }
        }
    }
    
    private func getRectangle(location1: Location,
                              location2: Location) -> MKPolygon {
        let clLocation1 = CLLocationCoordinate2D(latitude: location1.latitude,
                                                 longitude: location1.longitude)
        let clLocation2 = CLLocationCoordinate2D(latitude: location1.latitude,
                                                 longitude: location2.longitude)
        let clLocation3 = CLLocationCoordinate2D(latitude: location2.latitude,
                                                 longitude: location2.longitude)
        let clLocation4 = CLLocationCoordinate2D(latitude: location2.latitude,
                                                 longitude: location1.longitude)
        let rect = MKPolygon(coordinates: [clLocation1,
                                           clLocation2,
                                           clLocation3,
                                           clLocation4], count: 4)
        return rect
    }
    
    private func add(vehicle: Vehicle,
                     to mapView: MapView) {
        let location = vehicle.coordinate
        let clLocation = CLLocationCoordinate2D(latitude: location.latitude,
                                                longitude: location.longitude)
        let annotation = VehiclePointAnnotation(vehicle: vehicle)
        annotation.coordinate = clLocation
        annotation.title = vehicle.fleetType.displayName
        mapView.addAnnotation(annotation)
    }
}

extension VehiclesViewModel: TaxiMapViewProtocol {
    func visibleRegionChanged(to point1: Location,
                              from point2: Location) {
        fetchVehicles(point1: point1,
                      point2: point2)
    }
}
