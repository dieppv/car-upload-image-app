//
//  AppDelegate.swift
//  Smartphone_Drive_App
//
//  Created by Ominext Mac mini 5 on 7/15/20.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window?.translatesAutoresizingMaskIntoConstraints = false
        window?.makeKeyAndVisible()

        let vc = SplashVC()
        window?.rootViewController = vc
        
        return true
    }
}

