//
//  AppDelegate.swift
//  TagBoard
//
//  Created by Will Brandin on 11/4/19.
//  Copyright © 2019 Will Brandin. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        configureNetworkLayer()
        setupWindow()
        
        return true
    }
    
    // MARK: - Configuration
    
    func setupWindow() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = createLandingViewController()
        window?.makeKeyAndVisible()
    }
    
    func createHomeViewController() -> UIViewController {
        let home = HomeViewController()
        return home
    }
    
    func createLandingViewController() -> UIViewController {
        if #available(iOS 13.0, *) {
            let landing = LandingViewController()
            
            landing.onComplete = { [weak self] in
                self?.window?.rootViewController = self?.createHomeViewController()
            }
            
            return landing
        }
        
        return UIViewController()
    }
}
