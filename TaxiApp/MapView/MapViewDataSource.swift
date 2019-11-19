//
//  MapViewDataSource.swift
//  TaxiApp
//
//  Created by Dipak V. Vyawahare on 18/11/19.
//  Copyright © 2019 MyOrganization. All rights reserved.
//

import Foundation

@objc protocol MapViewDataSource: class {
    func addAnnotations(_ mapView: MapView)
    func drawOverlay(_ mapView: MapView)
    func resetFocus(_ mapView: MapView)
    func selectAnnotation(_ mapView: MapView,
                          at index: Int)
}

extension MapViewDataSource {
    func drawOverlay(_ mapView: MapView) {}
    func resetFocus(_ mapView: MapView) {}
    func selectAnnotation(_ mapView: MapView, at index: Int) {}
}
