//
//  ApplicationCoordinator.swift
//  TagBoard
//
//  Created by Will Brandin on 11/4/19.
//  Copyright © 2019 Will Brandin. All rights reserved.
//

import UIKit

class ApplicationCoordinator: NavigationFlowCoordinator {
    
    // MARK: - Properties
    
    private var isAuthenticated: Bool {
        return true
    }
    
    // MARK: - Methods
    
    override func createMainViewController() -> UIViewController? {
        if isAuthenticated {
            return createHomeListViewController()
        } else {
            return createLandingViewController()
        }
    }
    
    // MARK: - Private Methods
    
    private func createHomeListViewController() -> TBHomeListViewController {
        let homeListController = TBHomeListViewController()
        
        homeListController.onTapAdd = { [weak self] in
            let newBoard = TagBoard(id: nil, title: "New Tag", tags: [], createdDate: nil, lastUpdatedDate: nil)
            self?.presentTagBoardView(for: newBoard)
        }
        
        homeListController.onEdit = { [weak self] tagBoard in
            self?.presentTagBoardView(for: tagBoard)
        }
        
        homeListController.onTapSettings = { }
        
        return homeListController
    }
    
    private func createLandingViewController() -> LandingViewController {
        let landing = LandingViewController()
        
        landing.onComplete = {
            print("COMPLETE")
        }
        
        return landing
    }
    
    private func presentTagBoardView(for tagboard: TagBoard) {
        let viewModel = TagBoardViewModel(tagBoard: tagboard)
        let tagBoardViewController = TagBoardViewController(viewModel: viewModel)
        
        present(viewController: UINavigationController(rootViewController: tagBoardViewController))
    }
}
