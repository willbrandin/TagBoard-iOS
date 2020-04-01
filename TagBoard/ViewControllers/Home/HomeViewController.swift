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
        
        tagListViewController.onCopyTags = { [weak self] tags in
            self?.presentTagRefine(with: tags)
        }
        
        return tagListViewController
    }
    
    private func createTagViewController(for tagBoard: TagBoard) -> TagBoardViewController {
        tagBoardViewController = TagBoardViewController(viewModel: TagBoardViewModel(tagBoard: tagBoard))
        
        tagBoardViewController.onSave = { [weak self] tagBoard in
            self?.tagListViewController.didUpdate(tagBoard)
            self?.tagListViewController.navigationController?.popToRootViewController(animated: true)
        }
        
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
        let viewController = UIViewController()
        viewController.title = "Settings"
        viewController.view.backgroundColor = .background

        let controller = UINavigationController(rootViewController: viewController)
        viewController.navigationController?.navigationBar.prefersLargeTitles = true
        
        tagListViewController.navigationController?.present(controller, animated: true, completion: nil)
    }
    
    private func presentTagRefine(with tags: [TagBoard]) {
        let viewController = TagRefineViewController(viewModel: TagRefineViewModel(tagBoards: tags))
        let controller = UINavigationController(rootViewController: viewController)

        tagListViewController.navigationController?.present(controller, animated: true, completion: nil)
    }
}

extension UISplitViewController {
    func toggleMasterView() {
        let barButtonItem = self.displayModeButtonItem
        UIApplication.shared.sendAction(barButtonItem.action!, to: barButtonItem.target, from: nil, for: nil)
    }
}
