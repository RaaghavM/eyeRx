//
//  AppDelegate.swift
//  eyeRx
//
//  Created by ET USER on 6/15/20.
//  Copyright © 2020 mHealthWellnessLLC. All rights reserved.
//


import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        for _ in 1...FullEyedropListTableViewController.dropList.count
        {
            FavoritesData.shared.favorites += [false]
        }
        let defaults = UserDefaults.standard
        if let physicianInfo = defaults.string(forKey: defaultsKeys.physicianInfoKey) {
            FooterData.shared.physicianInfo = physicianInfo
            print(physicianInfo)
        }
        print(FooterData.shared.physicianInfo)
        if let patientInstructions = defaults.string(forKey: defaultsKeys.patientInstructionsKey) {
            FooterData.shared.patientInstructions = patientInstructions
            print(patientInstructions)
        }
        if let favorites = defaults.array(forKey: defaultsKeys.favoritesKey) {
            FavoritesData.shared.favorites = favorites as! [Bool]
        }
        print(FooterData.shared.patientInstructions)
        
        return true
    }

    func applicationWillTerminate(_ application: UIApplication) {
        let defaults = UserDefaults.standard
        defaults.set(FooterData.shared.physicianInfo, forKey: defaultsKeys.physicianInfoKey)
        defaults.set(FooterData.shared.patientInstructions, forKey: defaultsKeys.patientInstructionsKey)
        print(defaultsKeys.physicianInfoKey)
        print(defaultsKeys.patientInstructionsKey)
        defaults.set(FavoritesData.shared.favorites, forKey: defaultsKeys.favoritesKey)
    }
    
    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

struct defaultsKeys {
    static let physicianInfoKey = "PhysicianInfoKey"
    static let patientInstructionsKey = "PatientInstructionsKey"
    static let favoritesKey = "FavoritesKey"
}

