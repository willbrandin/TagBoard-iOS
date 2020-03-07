//
//  TBHomeListViewController.swift
//  TagBoard
//
//  Created by Will Brandin on 11/5/19.
//  Copyright © 2019 Will Brandin. All rights reserved.
//

import UIKit

class TBHomeListViewController: UITableViewController, LoadingView {
    
    // MARK: - Properties

    var onEdit: ((TagBoard) -> Void)?
    var onTapSettings: (() -> Void)?
    
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
        
        title = "Tag"
        view.backgroundColor = .background
        
        let settingsIcon = UIImage(systemName: "gear")?.withTintColor(.primary)
        let addIcon = UIImage(systemName: "plus")?.withTintColor(.primary)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: settingsIcon, style: .plain, target: self, action: #selector(didTapSettings))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: addIcon, style: .plain, target: self, action: #selector(didTapAdd))
        
        navigationController?.navigationBar.prefersLargeTitles = true

        tableView.register(TagListItemCell.self)
        tableView.allowsMultipleSelection = true
        
        subscribeToViewModel()
    }
    
    // MARK: - Private Methods
    
    private func subscribeToViewModel() {
        viewModel.onDataSourceUpdated = { [weak self] in
            self?.tableView.reloadData()
        }
        
        viewModel.onTapDisclosure = { [weak self] tagBoard in
            self?.showTagBoardModalSheet(for: tagBoard)
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
    
    private func showTagBoardModalSheet(for tagboard: TagBoard) {
        let editAction: () -> Void = { [weak self] in
            print("EDIT")
            self?.onEdit?(tagboard)
        }
        
        let deleteAction = {
            self.viewModel.delete(tagboard)
        }
        
        let cancelAction = {
            print("CANCEL")
        }
        
        let content = TagBoardModalSheetContent(name: tagboard.title, onTapEditAction: editAction, onTapDeleteAction: deleteAction, onTapCancelAction: cancelAction)
        let modalView = TagBoardModalSheet(content: content)
        view.showModalView(view: modalView)
    }
    
    func didUpdate(_ tag: TagBoard) {
        viewModel.didUpdate(tag)
    }
    
    // MARK: - Actions
    
    @objc private func didTapSettings() {
        print("SETTINGS")
        onTapSettings?()
        viewModel.requestList()
    }
    
    @objc private func didTapAdd() {
        let newBoard = TagBoard(id: nil, title: "New Tag", tags: [], createdDate: nil, lastUpdatedDate: nil)
        onEdit?(newBoard)
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
}
