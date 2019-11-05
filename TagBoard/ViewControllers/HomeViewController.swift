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
                
        let list = TBHomeListViewController()
        
        list.onSelect = { [weak self] index in
            let controller = UINavigationController(rootViewController: TagViewController())
            DispatchQueue.main.async {
                self?.showDetailViewController(controller, sender: nil)
            }
        }
        
        let master = UINavigationController(rootViewController: list)
        
        viewControllers = [master]
    }
}

class TBHomeListViewController: UITableViewController {
    
    var onSelect: ((Int) -> Void)?
    
    // MARK: - Initializer
    
    init() {
        super.init(style: .grouped)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Tags"
        
        if #available(iOS 13.0, *) {
            let settingsIcon = UIImage(systemName: "gear")
            let addIcon = UIImage(systemName: "plus")
            
            navigationItem.leftBarButtonItem = UIBarButtonItem(image: settingsIcon, style: .plain, target: self, action: #selector(didTapSettings))
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: addIcon, style: .plain, target: self, action: #selector(didTapAdd))
        }
    }
    
    // MARK: - Private Methods
    
    private func createNewCategory() {
        /**
         1. Add a new table item at end - title can be 'New Category 👍' Random emoji?
         2. Push a new Master Detail Item that is empty
         */
    }
    
    // MARK: - Actions
    
    @objc private func didTapSettings() {
        print("SETTINGS")
    }
    
    @objc private func didTapAdd() {
        print("ADD LIST")
    }
    
    // MARK: - UITableViewDelegate && UITableViewDataSource
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        return cell
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        onSelect?(indexPath.row)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNonzeroMagnitude
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNonzeroMagnitude
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
}

class TagViewController: UIViewController {
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Edit Tag"
    }
}
