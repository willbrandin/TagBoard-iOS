//
//  TagBoardModalSheet.swift
//  TagBoard
//
//  Created by Will Brandin on 3/5/20.
//  Copyright © 2020 Will Brandin. All rights reserved.
//

import UIKit

struct TagBoardModalSheetContent {
    let name: String
    let onTapEditAction: () -> Void
    let onTapDeleteAction: () -> Void
    let onTapCancelAction: () -> Void
}

class TagBoardModalSheet: ModalPresentable {
    
    // MARK: - Properties
    
    private var content: TagBoardModalSheetContent
    
    // MARK: - Subclasses
    
    private let contentView = UIView(frame: .zero)
    private let mainButtonWrapper = UIView(frame: .zero)
    private let titleLabel = UILabel(frame: .zero)
    private let editButton = UIButton(type: .system)
    private let deleteButton = UIButton(type: .system)
    private let cancelButton = UIButton(type: .system)
    
    // MARK: - Initializers
    
    init(content: TagBoardModalSheetContent) {
        self.content = content
        
        super.init(style: .clearStyle, presenterStyle: .bottomStyle)
        
        setupView()
        styleView()
        setContent()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    required init(style: ModalPresentableStyle, presenterStyle: ModalPresenterStyle) {
        fatalError("init(style:presenterStyle:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    private func setupView() {        
        addSubview(contentView)
        contentView.pinToSuperview()
        contentView.setMargins(top: 0, leading: Style.Layout.margin, bottom: 0, trailing: Style.Layout.margin)
        
        contentView.addSubview(mainButtonWrapper)
        mainButtonWrapper.pinToTop()
        mainButtonWrapper.pinToLeadingAndTrailingMargins()
        
        mainButtonWrapper.addSubview(titleLabel)
        titleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: Style.Layout.buttonHeight).isActive = true
        titleLabel.pinToLeadingAndTrailing()
        titleLabel.pinToTop()
        
        let titleDivider = DividerView()
        mainButtonWrapper.addSubview(titleDivider)
        titleDivider.pinToLeadingAndTrailing()
        titleDivider.pinBelowView(view: titleLabel)
        
        mainButtonWrapper.addSubview(editButton)
        editButton.heightAnchor.constraint(greaterThanOrEqualToConstant: Style.Layout.buttonHeight).isActive = true
        editButton.pinToLeadingAndTrailing()
        editButton.pinBelowView(view: titleDivider)
        
        let editDivider = DividerView()
        mainButtonWrapper.addSubview(editDivider)
        editDivider.pinToLeadingAndTrailing()
        editDivider.pinBelowView(view: editButton)

        mainButtonWrapper.addSubview(deleteButton)
        deleteButton.pinBelowView(view: editDivider)
        deleteButton.heightAnchor.constraint(greaterThanOrEqualToConstant: Style.Layout.buttonHeight).isActive = true
        deleteButton.pinToLeadingAndTrailing()
        deleteButton.pinToBottom()
        
        contentView.addSubview(cancelButton)
        cancelButton.heightAnchor.constraint(greaterThanOrEqualToConstant: Style.Layout.buttonHeight).isActive = true
        cancelButton.pinBelowView(view: mainButtonWrapper, constant: Style.Layout.marginXL)
        cancelButton.pinToLeadingAndTrailingMargins()
        cancelButton.pinToBottom(constant: Style.Layout.margin)
    }
    
    private func styleView() {
        mainButtonWrapper.backgroundColor = .secondarySystemBackground
        mainButtonWrapper.layer.cornerRadius = 8
        mainButtonWrapper.layer.masksToBounds = true

        titleLabel.textAlignment = .center
        titleLabel.font = Style.Font.body
        titleLabel.textColor = .secondaryText
        
        editButton.titleLabel?.font = Style.Font.headline
        editButton.titleLabel?.textAlignment = .center
        editButton.setTitleColor(.primaryText, for: .normal)
        editButton.backgroundColor = .secondarySystemBackground

        deleteButton.titleLabel?.font = Style.Font.headline
        deleteButton.titleLabel?.textAlignment = .center
        deleteButton.setTitleColor(.error, for: .normal)
        deleteButton.backgroundColor = .secondarySystemBackground

        cancelButton.titleLabel?.font = Style.Font.body
        cancelButton.titleLabel?.textAlignment = .center
        cancelButton.setTitleColor(.primaryText, for: .normal)
        cancelButton.backgroundColor = .secondarySystemBackground
        cancelButton.layer.cornerRadius = 8
    }
    
    private func setContent() {
        titleLabel.text = content.name
        editButton.setTitle("Edit", for: .normal)
        deleteButton.setTitle("Delete", for: .normal)
        cancelButton.setTitle("Cancel", for: .normal)
        
        editButton.addTarget(self, action: #selector(didTapEdit), for: .touchUpInside)
        deleteButton.addTarget(self, action: #selector(didTapDelete), for: .touchUpInside)
        cancelButton.addTarget(self, action: #selector(didTapCancel), for: .touchUpInside)
    }
    
    // MARK: - Actions
    
    @objc private func didTapEdit() {
        dismiss()
        content.onTapEditAction()
    }
    
    @objc private func didTapDelete() {
        dismiss()
        content.onTapDeleteAction()
    }
    
    @objc private func didTapCancel() {
        dismiss()
        content.onTapCancelAction()
    }
}
