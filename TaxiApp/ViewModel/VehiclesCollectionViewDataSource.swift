//
//  VehiclesCollectionViewDataSource.swift
//  TaxiApp
//
//  Created by Dipak V. Vyawahare on 19/11/19.
//  Copyright © 2019 MyOrganization. All rights reserved.
//

import UIKit

class VehiclesCollectionViewDataSource: NSObject, VehiclesDataSource, UICollectionViewDataSource {
    var data: VehicleObserver = VehicleObserver([])
    private var selectedIndex: Int?
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return data.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VehicleCollectionCellIdentifier",
                                                      for: indexPath as IndexPath)
        if let cell = cell as? VehicleCollectionViewCell {
            cell.vehicle = data.value[indexPath.item]
            let shouldShowSelected = indexPath.item != selectedIndex
            cell.showSelected(show: shouldShowSelected)
        }
        return cell
    }
    
    func showCellSelected(at index: Int) {
        selectedIndex = index
    }
}

extension FleetType {
    func mapDisplayImage() -> UIImage? {
        return UIImage(named: rawValue.lowercased())
    }
    
    func collectionDisplayImage() -> UIImage? {
        return UIImage(named: rawValue.lowercased() + "Coll")
    }
    
    var displayName: String {
        return rawValue.capitalized
    }
}
