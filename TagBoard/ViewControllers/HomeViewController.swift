//
//  HomeViewController.swift
//  TagBoard
//
//  Created by Will Brandin on 11/4/19.
//  Copyright © 2019 Will Brandin. All rights reserved.
//

import UIKit

class HomeViewController: UISplitViewController, UISplitViewControllerDelegate {
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        let tagListViewController = createHomeListViewController()
        let master = UINavigationController(rootViewController: tagListViewController)
        viewControllers = [master]
    }
    
    // MARK: - Private Methods
    
    private func createHomeListViewController() -> TBHomeListViewController {
        let tagListViewController = TBHomeListViewController()
        
        tagListViewController.onSelect = { [weak self] index in
            guard let controller = self?.createTagViewController() else {
                return
            }
            
            let navigation = UINavigationController(rootViewController: controller)
            self?.showDetailViewController(navigation, sender: nil)
        }
        
        return tagListViewController
    }
    
    private func createTagViewController() -> TagBoardViewController {
        let controller = TagBoardViewController()
        
        return controller
    }
}
