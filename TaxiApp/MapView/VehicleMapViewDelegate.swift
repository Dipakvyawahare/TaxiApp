//
//  VehicleMapViewDelegate.swift
//  TaxiApp
//
//  Created by Dipak V. Vyawahare on 18/11/19.
//  Copyright © 2019 MyOrganization. All rights reserved.
//

import MapKit

class VehicleMapViewDelegate: NSObject, MKMapViewDelegate {
    
    @objc weak var delegate: TaxiMapViewProtocol?
    
    func mapView(_ mapView: MKMapView,
                 viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !(annotation is MKUserLocation) else {
            return nil
        }
       
        var annotationView: MKAnnotationView?
        
        if let annotation = annotation as? VehiclePointAnnotation {
            let identifier  = "VehicleMapIdentifier"
            if let dequeuedAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier:
                identifier) {
                annotationView = dequeuedAnnotationView
                annotationView?.annotation = annotation
            } else {
                annotationView = MKAnnotationView(annotation: annotation,
                                                  reuseIdentifier: identifier)
            }
            
            if let annotationView = annotationView {
                annotationView.canShowCallout = true
                let car = annotation.vehicle.fleetType.mapDisplayImage()?
                    .rotated(by: CGFloat(annotation.vehicle.heading))
                annotationView.image = car
            }
        } else {
            let identifier = "PinMapIdentifier"
            if let dequeuedAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier:
                identifier) {
                annotationView = dequeuedAnnotationView
                annotationView?.annotation = annotation
            } else {
                annotationView = MKPinAnnotationView(annotation: annotation,
                                                  reuseIdentifier: identifier)
            }
            if let annotationView = annotationView as? MKPinAnnotationView {
                annotationView.animatesDrop = true
            }
        }
        
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView,
                 rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let poly = overlay as? MKPolygon {
            let polyRenderer = MKPolygonRenderer(overlay: poly)
            polyRenderer.fillColor = .lightGray
            polyRenderer.alpha = 0.3
            return polyRenderer
        }
        return MKOverlayRenderer()
    }
    
    func mapView(_ mapView: MKMapView,
                 regionDidChangeAnimated animated: Bool) {
        if !animated {
            let latSpan = mapView.region.span.latitudeDelta * 0.45
            let longSpan = mapView.region.span.longitudeDelta * 0.45
            let center =  mapView.region.center
            let point1 = Location(latitude: center.latitude + latSpan,
                                  longitude: center.longitude + longSpan)
            let point2 = Location(latitude: center.latitude - latSpan,
                                  longitude: center.longitude - longSpan)
            delegate?.visibleRegionChanged(to: point1,
                                           from: point2)
        }
    }
}
