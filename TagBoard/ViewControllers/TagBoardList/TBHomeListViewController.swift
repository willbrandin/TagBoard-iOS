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
    var onCopyTags:(([TagBoard]) -> Void)?
    
    private var viewModel = TBHomeListViewModel()
    private var copyButtonBottomConstraint: NSLayoutConstraint!
    
    // MARK: - Subviews
    
    private let copyButton = UIButton(type: .system)
        
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
        
        view.setMargins(top: Style.Layout.margin, leading: Style.Layout.margin, bottom: Style.Layout.margin, trailing: Style.Layout.margin)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: .gear, style: .plain, target: self, action: #selector(didTapSettings))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: .plus, style: .plain, target: self, action: #selector(didTapAdd))
        navigationController?.navigationBar.prefersLargeTitles = true

        tableView.register(TagListItemCell.self)
        tableView.allowsMultipleSelection = true
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 90, right: 0)
        setupCopyButton()
        subscribeToViewModel()
    }
    
    // MARK: - Methods
    
    func didUpdate(_ tag: TagBoard) {
        viewModel.didUpdate(tag)
    }
    
    // MARK: - Private Methods
    
    private func subscribeToViewModel() {
        viewModel.onDataSourceUpdated = { [weak self] in
            self?.tableView.reloadData()
        }
        
        viewModel.onTapDisclosure = { [weak self] tagBoard in
            self?.showTagBoardModalSheet(for: tagBoard)
        }
        
        viewModel.onDisplayCopyButton = { [weak self] showButton in
            DispatchQueue.main.async {
                if showButton {
                    self?.showButton()
                } else {
                    self?.hideButton()
                }
            }
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
    
    private func setupCopyButton() {
        view.addSubview(copyButton)
        copyButton.translatesAutoresizingMaskIntoConstraints = false
        copyButtonBottomConstraint = copyButton.pinToBottomMargin()
        copyButton.pinToLeadingAndTrailingMargins()
        copyButton.heightAnchor.constraint(equalToConstant: Style.Layout.buttonHeight).isActive = true
        
        copyButton.layer.cornerRadius = 8.0
        copyButton.titleLabel?.font = Style.Font.headline
        copyButton.titleLabel?.textAlignment = .center
        copyButton.setTitleColor(.white, for: .normal)
        copyButton.backgroundColor = .primary
        copyButton.setTitle("Copy Tags", for: .normal)
        copyButton.addTarget(self, action: #selector(didTapCopy), for: .touchUpInside)
        copyButton.alpha = 0
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
        
    private func showButton() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: { [weak self] in
            self?.copyButtonBottomConstraint.constant = -Style.Layout.margin
            self?.view.layoutIfNeeded()
            self?.copyButton.alpha = 1
        })
        
        let tagCount = viewModel.selectedBoards.compactMap({ $0.tags.count }).reduce(0, +)
        copyButton.setTitle("Copy \(tagCount) Hashtags!", for: .normal)
    }
    
    private func hideButton() {
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseIn, animations: { [weak self] in
            self?.copyButtonBottomConstraint.constant = Style.Layout.margin + 100
            self?.view.layoutIfNeeded()
            self?.copyButton.alpha = 0
        })
    }
    
    // MARK: - Actions
    
    @objc private func didTapSettings() {
        print("SETTINGS")
        onTapSettings?()
    }
    
    @objc private func didTapCopy() {
        onCopyTags?(viewModel.selectedBoards)
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelect(at: indexPath.row)
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        viewModel.didDeselect(at: indexPath.row)
    }
}
