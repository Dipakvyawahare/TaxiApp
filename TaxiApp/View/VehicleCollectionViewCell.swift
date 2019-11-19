//
//  VehicleCollectionViewCell.swift
//  TaxiApp
//
//  Created by Dipak V. Vyawahare on 19/11/19.
//  Copyright © 2019 MyOrganization. All rights reserved.
//

import UIKit

class VehicleCollectionViewCell: UICollectionViewCell {
    @IBOutlet private weak var imageView: UIImageView?
    @IBOutlet private weak var fleetType: UILabel?
    
    var vehicle: Vehicle? {
        didSet {
            imageView?.image = vehicle?.fleetType.collectionDisplayImage()
            fleetType?.text = vehicle?.fleetType.displayName
        }
    }
    
    func showSelected(show: Bool) {
        if let layer = imageView?.superview?.layer {
            layer.cornerRadius = 10
            if show == true {
                layer.borderWidth = 1
                layer.borderColor = UIColor.darkGray.cgColor
            } else {
                layer.borderWidth = 3
                layer.borderColor = UIColor(red: 0/255,
                                            green: 30/255, 
                                            blue: 60/255,
                                            alpha: 0.9).cgColor
            }
        }
    }
}
