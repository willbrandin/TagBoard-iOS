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
    private var applicationCoordinator: ApplicationCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        configureNetworkLayer()
        setupWindow()
        
        return true
    }
    
    // MARK: - Configuration
    
    func setupWindow() {
        let standard = UINavigationBarAppearance()
        standard.configureWithTransparentBackground()
        standard.backgroundColor = .background
        standard.titleTextAttributes = [.foregroundColor: UIColor.primaryText]
        
        UINavigationBar.appearance().standardAppearance = standard
        UINavigationBar.appearance().scrollEdgeAppearance = standard
        
        applicationCoordinator = ApplicationCoordinator()
        applicationCoordinator?.start(with: .push, animated: false)
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = applicationCoordinator?.navigationController
        window?.makeKeyAndVisible()
    }
}
