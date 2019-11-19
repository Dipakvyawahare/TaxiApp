//
//  DisplayFixedBoundVehicleViewController.swift
//  TaxiApp
//
//  Created by Dipak V. Vyawahare on 18/11/19.
//  Copyright © 2019 MyOrganization. All rights reserved.
//

import UIKit

class DisplayFixedBoundVehicleViewController: UIViewController {
    
    @IBOutlet weak var mapView: MapView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    let mapViewDataSource = VehiclesMapDataSource()
    let collectionViewDataSource = VehiclesCollectionViewDataSource()
    let mapViewConfigurator = VehicleMapViewDelegate()
    
    lazy var viewModel: VehiclesViewModel = {
        let viewModel = VehiclesViewModel(dataSources: [mapViewDataSource, collectionViewDataSource])
        return viewModel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = collectionViewDataSource
        collectionView.delegate = self
        mapView.dataSource = mapViewDataSource
        mapView.delegate = mapViewConfigurator
        mapViewDataSource.data.addAndNotify(observer: self) { [weak self] in
            self?.mapView.reloadAnnotations()
            self?.mapView.fitMapViewToAnnotaionList()
        }
        collectionViewDataSource.data.addAndNotify(observer: self) { [weak self] in
            self?.collectionView.reloadData()
        }
        observeErrors()
        
        mapView.resetFocus()
        mapView.drawOverlay()
        viewModel.fetchVehicles()
    }
    
    func observeErrors() {
        self.viewModel.onErrorHandling = { [weak self] error in
            let controller = UIAlertController(title: "An error occured",
                                               message: error?.message ?? "",
                                               preferredStyle: .alert)
            controller.addAction(UIAlertAction(title: "Close",
                                               style: .cancel,
                                               handler: { [weak self] (_) in
                                                self?.navigationController?.popViewController(animated: true)
            }))
            self?.present(controller,
                          animated: true,
                          completion: nil)
        }
    }
}

extension DisplayFixedBoundVehicleViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        mapView.selectAnnotation(at: indexPath.item)
        collectionViewDataSource.showCellSelected(at: indexPath.item)
        collectionView.reloadData()
    }
}
