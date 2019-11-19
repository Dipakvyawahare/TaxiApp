//
//  MKMapViewExtensions.swift
//  TaxiApp
//
//  Created by Dipak V. Vyawahare on 18/11/19.
//  Copyright © 2019 MyOrganization. All rights reserved.
//

import MapKit

typealias Edges = (ne: CLLocationCoordinate2D, sw: CLLocationCoordinate2D)

extension MKMapView {
    func fitMapViewToAnnotaionList() {
        let mapEdgePadding = UIEdgeInsets(top: 20,
                                          left: 20,
                                          bottom: 20,
                                          right: 20)
        var zoomRect: MKMapRect = MKMapRect.null
        for index in 0..<self.annotations.count {
            let annotation = self.annotations[index]
            let aPoint: MKMapPoint = MKMapPoint(annotation.coordinate)
            let rect: MKMapRect = MKMapRect(x: aPoint.x,
                                            y: aPoint.y,
                                            width: 0.1,
                                            height: 0.1)
            if zoomRect.isNull {
                zoomRect = rect
            } else {
                zoomRect = zoomRect.union(rect)
            }
        }
        setVisibleMapRect(zoomRect,
                          edgePadding: mapEdgePadding,
                          animated: true)
    }
}
