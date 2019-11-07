//
//  TBHomeListViewController.swift
//  TagBoard
//
//  Created by Will Brandin on 11/5/19.
//  Copyright © 2019 Will Brandin. All rights reserved.
//

import UIKit

class TBHomeListViewController: UITableViewController {
    
    // MARK: - Properties

    var onSelect: ((Int) -> Void)?
    var onTapAdd: (() -> Void)?
    var onTapSettings: (() -> Void)?
    var onDelete: ((Int) -> Void)?
    
    private var viewModel = TBHomeListViewModel()
    
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
        
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPress(longPressGestureRecognizer:)))
        view.addGestureRecognizer(longPressRecognizer)
        
        subscribeToViewModel()
    }
    
    // MARK: - Methods
    
    func setDataSource(_ tagBoards: [TagBoard]) {
        viewModel.injectDataSource(tagBoards)
    }
    
    // MARK: - Private Methods
    
    private func subscribeToViewModel() {
        viewModel.onDataSourceUpdated = { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    private func createNewCategory() {
        /**
         1. Add a new table item at end - title can be 'New Category 👍' Random emoji?
         2. Push a new Master Detail Item that is empty
         */
    }
    
    // MARK: - Actions
    
    @objc private func longPress(longPressGestureRecognizer: UILongPressGestureRecognizer) {
        if longPressGestureRecognizer.state == .began {

            let touchPoint = longPressGestureRecognizer.location(in: tableView)
            if let indexPath = tableView.indexPathForRow(at: touchPoint) {
                // your code here, get the row for the indexPath or do whatever you want
                print("LONG PRESS AT - \(indexPath)")
                navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(didTapCancel))
            }
        }
    }
    
    @objc private func didTapSettings() {
        print("SETTINGS")
        onTapSettings?()
    }
    
    @objc private func didTapAdd() {
        onTapAdd?()
    }
    
    @objc private func didTapCancel() {
        if #available(iOS 13.0, *) {
            let addIcon = UIImage(systemName: "plus")
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: addIcon, style: .plain, target: self, action: #selector(didTapAdd))
        }
    }
}

// MARK: - UITableViewDelegate && UITableViewDataSource

extension TBHomeListViewController {
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return viewModel.cellForRow(tableView, cellForRowAt: indexPath)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        onSelect?(indexPath.row)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows
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
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            onDelete?(indexPath.row)
        }
    }
}
