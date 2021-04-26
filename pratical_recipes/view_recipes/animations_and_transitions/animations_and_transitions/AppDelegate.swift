//
//  AppDelegate.swift
//  animations_and_transitions
//
//  Created by FulltrackMobile on 29/02/20.
//  Copyright © 2020 rvsm. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UINavigationController(rootViewController: MainView(nibName: "MainView", bundle: .main))
        window?.makeKeyAndVisible()
        return true
    }
}

