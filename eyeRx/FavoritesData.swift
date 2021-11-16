//
//  FavoritesData.swift
//  eyeRx
//
//  Created by ET USER on 8/10/20.
//  Copyright © 2020 mHealthWellnessLLC. All rights reserved.
//

import UIKit
class FavoritesData: NSObject {
    static let shared: FavoritesData = FavoritesData()
    var favorites = [Bool]()
}
