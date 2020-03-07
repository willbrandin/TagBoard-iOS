//
//  HomeViewController.swift
//  TagBoard
//
//  Created by Will Brandin on 11/4/19.
//  Copyright © 2019 Will Brandin. All rights reserved.
//

import UIKit

class HomeViewController: UISplitViewController, UISplitViewControllerDelegate, LoadingView {
    
    // MARK: - Properties
    
    private var tagListViewController: TBHomeListViewController!
    private var tagBoardViewController: TagBoardViewController!
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tagListViewController = createHomeListViewController()
        let master = UINavigationController(rootViewController: tagListViewController)
        viewControllers = [master]
    }

    // MARK: - Child View Controllers
    
    private func createHomeListViewController() -> TBHomeListViewController {
        tagListViewController = TBHomeListViewController()
        
        tagListViewController.onEdit = { [weak self] tagBoard in
            self?.showTagViewControllerAsDetail(for: tagBoard)
        }
        
        tagListViewController.onTapSettings = { [weak self] in
            self?.presentSettings()
        }
        
        return tagListViewController
    }
    
    private func createTagViewController(for tagBoard: TagBoard) -> TagBoardViewController {
        tagBoardViewController = TagBoardViewController(viewModel: TagBoardViewModel(tagBoard: tagBoard))
        return tagBoardViewController
    }
    
    private func showTagViewControllerAsDetail(for tagBoard: TagBoard) {
        let controller = createTagViewController(for: tagBoard)
        let navigation = UINavigationController(rootViewController: controller)
        tagListViewController.navigationController?.popToRootViewController(animated: true)
        showDetailViewController(navigation, sender: nil)
        toggleMasterView()
    }
    
    private func presentSettings() {
        
    }
}

extension UISplitViewController {
    func toggleMasterView() {
        let barButtonItem = self.displayModeButtonItem
        UIApplication.shared.sendAction(barButtonItem.action!, to: barButtonItem.target, from: nil, for: nil)
    }
}
