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
    
    var onSave: ((TagBoard) -> Void)?
    
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
    
    deinit {
        print("DEINIT - \(String(describing: self))")
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
        
        titleTextField.font = Style.Font.title
        titleTextField.text = viewModel.title
        titleTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    private func setupTagsTextView() {
        view.addSubview(tagsTextView)
        tagsTextView.pinToLeadingAndTrailingMargins()
        tagsTextView.pinBelowView(view: titleTextField, constant: Style.Layout.marginXL)
        tagsTextView.pinToBottomMargin()
        
        tagsTextView.delegate = self
        tagsTextView.font = Style.Font.body

        if viewModel.tags.isEmpty {
            tagsTextView.text = "#Enter #Your #Hashtags #Here"
            tagsTextView.textColor = .placeholder
        } else {
            tagsTextView.text = viewModel.tags.joined(separator: " ")
        }
    }
    
    // MARK: - Actions
    
    @objc private func didTapSave() {
        onSave?(viewModel.save())
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        guard let text = textField.text else {
            return
        }
        
        viewModel.update(text)
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
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == " " {
            textView.insertText(" #")
            return false
        }
        
        return true
    }
}
