//
//  ApplicationCoordinator.swift
//  TagBoard
//
//  Created by Will Brandin on 11/4/19.
//  Copyright © 2019 Will Brandin. All rights reserved.
//

import UIKit

class ApplicationCoordinator: NavigationFlowCoordinator {
    
    override func createMainViewController() -> UIViewController? {
        let home = HomeViewController()
        home.viewControllers = [TBHomeListViewController(), TagViewController()]
        return home
    }
    
}
