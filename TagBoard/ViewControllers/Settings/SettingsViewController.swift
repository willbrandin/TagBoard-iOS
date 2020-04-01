//
//  SettingsViewController.swift
//  TagBoard
//
//  Created by Will Brandin on 4/1/20.
//  Copyright © 2020 Will Brandin. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    // MARK: - Properties
    
    var viewModel = SettingsViewModel()
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    
    // MARK: - Initializer
    
    deinit {
        print("DEINIT - \(String(describing: self))")
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Settings"
        view.backgroundColor = .background
        navigationController?.navigationBar.prefersLargeTitles = true
        addCloseButton(image: .close)

        setupTableView()
    }
    
    // MARK: - Private Methods
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.pinToSuperview()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(LargeTableViewHeader.self)
        tableView.register(CenteredSingleLineCell.self)
        tableView.register(PrefixTableViewCell.self)
    }
}
