//
//  TagListItemCell.swift
//  TagBoard
//
//  Created by Will Brandin on 3/5/20.
//  Copyright © 2020 Will Brandin. All rights reserved.
//

import UIKit

struct TagListItemContent {
    let title: String
    let detail: String
    let disclosureAction: (() -> Void)
}

class TagListItemCell: UITableViewCell, CellLoadableView {
    
    // MARK: - Properties
    
    private var disclosureAction: (() -> Void)?
    
    // MARK: - Subclasses
    
    private let selectedImageView = UIImageView(frame: .zero)
    private let titleLabel = UILabel(frame: .zero)
    private let subtitleLabel = UILabel(frame: .zero)
    private let editImageView = UIButton(type: .system)
    
    // MARK: - Initializer
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configure(for: traitCollection)
        styleView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        let image: UIImage? = selected ? .checkMarkFill : .circle
        selectedImageView.image = image
        selectedImageView.tintColor = selected ? .primary : .secondaryText
    }
    
    func setCellContent(_ content: TagListItemContent) {
        titleLabel.text = content.title
        subtitleLabel.text = content.detail
        editImageView.setImage(.ellipsis, for: .normal)
        editImageView.tintColor = .secondaryText
        disclosureAction = content.disclosureAction
        editImageView.addTarget(self, action: #selector(didTapDisclosure), for: .touchUpInside)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
            
        if previousTraitCollection?.preferredContentSizeCategory != traitCollection.preferredContentSizeCategory {
            configure(for: traitCollection)
        }
    }
    
    private func configure(for traitCollection: UITraitCollection) {
        if traitCollection.preferredContentSizeCategory > .accessibilityLarge {
            setupLargeAccessibilityView()
        } else {
            setupView()
        }
    }
    
    // MARK: - Private Methods
    
    private func setupView() {
        contentView.setMargins(top: Style.Layout.innerSpacing, leading: Style.Layout.margin, bottom: Style.Layout.innerSpacing, trailing: Style.Layout.margin)
        
        contentView.addSubview(selectedImageView)
        selectedImageView.pinToLeadingMargin()
        selectedImageView.pinToVerticalCenter()
        
        let textWrapper = UIView()
        contentView.addSubview(textWrapper)
        textWrapper.pinLeadingToView(view: selectedImageView, constant: Style.Layout.innerSpacing)
        textWrapper.pinToTopMargin()
        textWrapper.pinToBottomMargin()
        
        textWrapper.addSubview(titleLabel)
        titleLabel.pinToLeadingAndTrailing()
        titleLabel.pinToTop()
        
        textWrapper.addSubview(subtitleLabel)
        subtitleLabel.pinToLeadingAndTrailing()
        subtitleLabel.pinToBottom()
        subtitleLabel.pinBelowView(view: titleLabel)
        
        contentView.addSubview(editImageView)
        editImageView.pinToTrailingMargin()
        editImageView.pinToVerticalCenter()
    }
    
    private func setupLargeAccessibilityView() {
        contentView.setMargins(top: Style.Layout.innerSpacing, leading: Style.Layout.margin, bottom: Style.Layout.innerSpacing, trailing: Style.Layout.margin)
        
        let textWrapper = UIView()
        contentView.addSubview(textWrapper)
        textWrapper.pinToLeadingMargin()
        textWrapper.pinToTopMargin()
        textWrapper.pinToBottomMargin()
        
        textWrapper.addSubview(titleLabel)
        titleLabel.pinToLeadingAndTrailing()
        titleLabel.pinToTop()
        
        textWrapper.addSubview(subtitleLabel)
        subtitleLabel.pinToLeadingAndTrailing()
        subtitleLabel.pinToBottom()
        subtitleLabel.pinBelowView(view: titleLabel)
        
        let iconWrapper = UIView()
        contentView.addSubview(iconWrapper)
        iconWrapper.pinToTrailingMargin()
        iconWrapper.pinLeadingToView(view: textWrapper, constant: Style.Layout.innerSpacing)
        iconWrapper.pinToTopMargin()
        iconWrapper.pinToBottomMargin()
        
        iconWrapper.addSubview(selectedImageView)
        selectedImageView.pinToTopMargin()
        selectedImageView.pinToLeadingAndTrailingMargins()
        
        iconWrapper.addSubview(editImageView)
        editImageView.pinToBottomMargin()
        editImageView.pinToLeadingAndTrailingMargins()
        editImageView.pinBelowView(view: selectedImageView)
    }
    
    private func styleView() {
        selectedImageView.tintColor = isSelected ? .primary : .secondaryText
        selectedImageView.contentMode = .scaleAspectFit
        titleLabel.textColor = .primaryText
        titleLabel.font = Style.Font.headline
        subtitleLabel.textColor = .secondaryText
        subtitleLabel.font = Style.Font.headline
        editImageView.contentMode = .scaleAspectFit
    }
    
    // MARK: - Actions
    
    @objc private func didTapDisclosure() {
        if let action = disclosureAction {
            action()
        }
    }
}
