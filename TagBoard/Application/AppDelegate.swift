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
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleSignOut), name: .unauthorized, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleSignOut), name: .logout, object: nil)

        return true
    }
    
    // MARK: - Configuration
    
    private func setupWindow() {
        window = UIWindow(frame: UIScreen.main.bounds)
        setRootView()
        window?.makeKeyAndVisible()
        
        let standard = UINavigationBarAppearance()
        standard.configureWithTransparentBackground()
        standard.backgroundColor = .background
        standard.titleTextAttributes = [.foregroundColor: UIColor.primaryText]
        
        UINavigationBar.appearance().standardAppearance = standard
        UINavigationBar.appearance().scrollEdgeAppearance = standard
        UINavigationBar.appearance().tintColor = .primaryText
    }
    
    private func createHomeViewController() -> UIViewController {
        let home = HomeViewController()
        return home
    }
    
    private func createLandingViewController() -> UIViewController {
        let landing = LandingViewController()
        
        landing.onComplete = { [weak self] in
            self?.window?.rootViewController = self?.createHomeViewController()
        }
        
        return landing
    }
    
    private func setRootView() {
        let isSignedIn = UserDefaultsManager.bearerToken != nil && UserDefaultsManager.user != nil
        window?.rootViewController = isSignedIn ? createHomeViewController() : createLandingViewController()
    }
    
    // MARK: - Actions
    
    @objc private func handleSignOut() {
        UserDefaultsManager.isAddingPrefix = false
        UserDefaultsManager.bearerToken = nil
        UserDefaultsManager.user = nil
        setRootView()
    }
}
