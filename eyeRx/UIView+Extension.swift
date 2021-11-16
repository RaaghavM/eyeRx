//
//  UIView+Extension.swift
//  eyeRx
//
//  Created by ET USER on 6/19/20.
//  Copyright © 2020 mHealthWellnessLLC. All rights reserved.
//

import UIKit

extension UIView {
 func toImage() -> UIImage {
    UIGraphicsBeginImageContextWithOptions(bounds.size, false, UIScreen.main.scale)

    drawHierarchy(in: self.bounds, afterScreenUpdates: true)

    let image = UIGraphicsGetImageFromCurrentImageContext()!
    UIGraphicsEndImageContext()
    return image
 }
}
