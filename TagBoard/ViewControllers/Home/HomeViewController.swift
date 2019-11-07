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
    
    private var viewModel = HomeViewModel()
    private var tagListViewController: TBHomeListViewController!
    private var tagBoardViewController: TagBoardViewController!
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        let tagListViewController = createHomeListViewController()
        let master = UINavigationController(rootViewController: tagListViewController)
        viewControllers = [master]
        
        subscribeToViewModel()
    }
    
    // MARK: - Private Methods
    
    private func subscribeToViewModel() {
        viewModel.onDataSourceChanged = { tagBoards in
            self.tagListViewController.setDataSource(tagBoards)
        }
        
        viewModel.onIsLoading = { [weak self] isLoading in
            DispatchQueue.main.async {
                if isLoading {
                    self?.showLoadingView()
                } else {
                    self?.hideLoadingView()
                }
            }
        }
        
        viewModel.requestList()
    }
    
    // MARK: - Child View Controllers
    
    private func createHomeListViewController() -> TBHomeListViewController {
        tagListViewController = TBHomeListViewController()
        
        tagListViewController.onSelect = { [weak self] index in
            guard let board = self?.viewModel.tagBaord(for: index) else {
                return
            }
            
            // TODO: - For now push, but this will be the copy action.
            self?.showTagViewControllerAsDetail(for: board)
        }
        
        tagListViewController.onDelete = { [weak self] index in
            self?.viewModel.delete(at: index)
            
            // Only the master view is visible
            if self?.viewControllers.count ?? 1 > 1 {
                self?.viewControllers.removeLast()
            }
        }
        
        tagListViewController.onTapSettings = { [weak self] in
            self?.viewModel.requestList()
        }
        
        tagListViewController.onTapAdd = { [weak self] in
            let newBoard = TagBoard(id: nil, title: "New Tag", tags: [], createdDate: nil, lastUpdatedDate: nil)
            self?.viewModel.addNew(newBoard)
            self?.showTagViewControllerAsDetail(for: newBoard)
        }
        
        return tagListViewController
    }
    
    private func createTagViewController(for tagBoard: TagBoard) -> TagBoardViewController {
        tagBoardViewController = TagBoardViewController()
        tagBoardViewController.title = tagBoard.title
        return tagBoardViewController
    }
    
    private func showTagViewControllerAsDetail(for tagBoard: TagBoard) {
        let controller = createTagViewController(for: tagBoard)
        let navigation = UINavigationController(rootViewController: controller)
        showDetailViewController(navigation, sender: nil)
    }
}
