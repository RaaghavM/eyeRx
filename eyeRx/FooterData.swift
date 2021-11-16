//
//  FooterData.swift
//  eyeRx
//
//  Created by ET USER on 8/9/20.
//  Copyright © 2020 mHealthWellnessLLC. All rights reserved.
//

import UIKit
class FooterData: NSObject {
    static let shared: FooterData = FooterData()
    var physicianInfo = ""
    var patientInstructions = "Only 1 drop required for instillation per eye\nAfter placing drop in eye, close eyes for 2 minutes\nWait at least 5 minutes before placing another eye drop medication\nShake bottle before use"
}
