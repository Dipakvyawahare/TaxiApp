//
//  UIImageExtensions.swift
//  TaxiApp
//
//  Created by Dipak V. Vyawahare on 18/11/19.
//  Copyright © 2019 MyOrganization. All rights reserved.
//

import UIKit

extension UIImage {
    func rotated(by angle: CGFloat) -> UIImage? {
        let radians: (CGFloat) -> CGFloat = {
            return $0 / 180.0 * CGFloat(Double.pi)
        }
        var newSize = CGRect(origin: CGPoint.zero,
                             size: self.size).applying(CGAffineTransform(rotationAngle: CGFloat(radians(angle)))).size
        // Trim off the extremely small float value to prevent core graphics from rounding it up
        newSize.width = newSize.width.rounded()
        newSize.height = newSize.height.rounded()
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, self.scale)
        let context = UIGraphicsGetCurrentContext()!
        // Move origin to middle
        context.translateBy(x: newSize.width/2, y: newSize.height/2)
        // Rotate around middle
        context.rotate(by: CGFloat(radians(angle)))
        // Draw the image at its center
        self.draw(in: CGRect(x: -self.size.width/2,
                             y: -self.size.height/2,
                             width: self.size.width,
                             height: self.size.height))
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
}
