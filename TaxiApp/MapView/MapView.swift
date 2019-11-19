//
//  MapView.swift
//  TaxiApp
//
//  Created by Dipak V. Vyawahare on 18/11/19.
//  Copyright © 2019 MyOrganization. All rights reserved.
//

import MapKit

class MapView: UIView {
    @IBOutlet weak var mapView: MKMapView!
    @objc weak var delegate: MKMapViewDelegate? {
        didSet {
            mapView.delegate = delegate
        }
    }
    @objc weak var dataSource: MapViewDataSource?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commomInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commomInit()
    }
    
    private func commomInit() {
        let nibName = "MapView"
        guard let contentView = Bundle.main.loadNibNamed(nibName,
                                                         owner: self,
                                                         options: nil)?.first as? UIView else { return }
        self.addSubview(contentView)
        contentView.pinToSuperView()
        mapView.isRotateEnabled = false
    }
    
    @objc func reloadAnnotations() {
        mapView.removeAnnotations(mapView.annotations)
        dataSource?.addAnnotations(self)
    }
    
    @objc func drawOverlay() {
        dataSource?.drawOverlay(self)
    }
    
    @objc func resetFocus() {
        dataSource?.resetFocus(self)
    }
    
    @objc func fitMapViewToAnnotaionList() {
        mapView.fitMapViewToAnnotaionList()
    }
    
    func selectAnnotation(at index: Int) {
        dataSource?.selectAnnotation(self, at: index)
    }
    
    func removeAnnotation(annotation: MKAnnotation) {
        mapView.removeAnnotation(annotation)
    }
    
    func setCenter(_ coordinate: CLLocationCoordinate2D,
                   animated: Bool) {
        mapView.setCenter(coordinate,
                          animated: animated)
    }
    
    func addAnnotation(_ annotation: MKAnnotation) {
        mapView.addAnnotation(annotation)
    }
    
    func setVisibleMapRect(_ mapRect: MKMapRect,
                           edgePadding insets: UIEdgeInsets,
                           animated animate: Bool) {
        mapView.setVisibleMapRect(mapRect,
                                  edgePadding: insets,
                                  animated: animate)
    }
    
    func addOverlay(_ overlay: MKOverlay) {
        mapView.addOverlay(overlay)
    }
}
