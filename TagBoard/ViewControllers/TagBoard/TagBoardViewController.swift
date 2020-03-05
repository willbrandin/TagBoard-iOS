//
//  TagBoardViewController.swift
//  TagBoard
//
//  Created by Will Brandin on 11/5/19.
//  Copyright © 2019 Will Brandin. All rights reserved.
//

import UIKit

class TagBoardViewController: UIViewController {
    
    // MARK: - Properties
    
    var onSave: (() -> Void)?
    
    private var viewModel: TagBoardViewModel
    
    private let titleTextField = UITextField()
    private let tagsTextView = UITextView()
    
    // MARK: - Initializer
    
    init(viewModel: TagBoardViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .background
        view.setMargins(top: Style.Layout.margin,
                        leading: Style.Layout.margin,
                        bottom: Style.Layout.margin,
                        trailing: Style.Layout.margin)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: viewModel.saveButtonTitle, style: .plain, target: self, action: #selector(didTapSave))
        
        setupTitleTextField()
        setupTagsTextView()
        subscribeToViewModel()
        
        navigationItem.largeTitleDisplayMode = .never
    }
    
    // MARK: - Private Methods
    
    private func subscribeToViewModel() {
        viewModel.onDidUpdateTags = { tags in }
        viewModel.onUpdateTitle = { [weak self] title in
            self?.titleTextField.text = title
        }
    }
    
    private func setupTitleTextField() {
        view.addSubview(titleTextField)
        titleTextField.pinToLeadingAndTrailingMargins()
        titleTextField.pinToTopMargin()
        
        titleTextField.font = Style.Font.h1
        titleTextField.text = viewModel.title
    }
    
    private func setupTagsTextView() {
        view.addSubview(tagsTextView)
        tagsTextView.pinToLeadingAndTrailingMargins()
        tagsTextView.pinBelowView(view: titleTextField, constant: Style.Layout.marginXL)
        tagsTextView.pinToBottomMargin()
        
        tagsTextView.delegate = self
        tagsTextView.text = "#Enter #Your #Hashtags #Here"
        tagsTextView.textColor = .placeholder
        tagsTextView.font = Style.Font.body
    }
    
    // MARK: - Actions
    
    @objc private func didTapSave() {
        onSave?()
    }
}

extension TagBoardViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .placeholder {
            tagsTextView.text = nil
            tagsTextView.textColor = .primaryText
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            tagsTextView.text = "#Enter #Your #Hashtags #Here"
            tagsTextView.textColor = .placeholder
        }
    }
}
