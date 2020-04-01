//
//  PrefixTableViewCell.swift
//  TagBoard
//
//  Created by Will Brandin on 4/1/20.
//  Copyright © 2020 Will Brandin. All rights reserved.
//

import UIKit

class PrefixTableViewCell: UITableViewCell, CellLoadableView {
    
    // MARK: - Properties
    
    var onSwitchChanged: ((Bool) -> Void)?
    
    private let titleLabel = UILabel(frame: .zero)
    private let switchControl = UISwitch(frame: .zero)
    private let prefixLabel = UILabel(frame: .zero)
    
    private let titleText = "Hashtag Prefix"
    private let prefixText = "•\n•\n•\n•\n•"
    
    // MARK: - Initializer
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
        styleView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    func setSwitch(isOn: Bool) {
        switchControl.isOn = isOn
    }
    
    // MARK: - Private Methods
    
    private func setupView() {
        contentView.setMargins(top: Style.Layout.innerSpacing,
                               leading: Style.Layout.innerSpacing,
                               bottom: Style.Layout.innerSpacing,
                               trailing: Style.Layout.innerSpacing)
        
        contentView.addSubview(titleLabel)
        titleLabel.pinToTopMargin()
        titleLabel.pinToLeadingMargin()
        
        contentView.addSubview(switchControl)
        switchControl.alignVerticalCenterToView(view: titleLabel)
        switchControl.pinToTrailingMargin()
        switchControl.heightAnchor.constraint(equalToConstant: 32).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: switchControl.leadingAnchor, constant: -Style.Layout.margin).isActive = true
        switchControl.addTarget(self, action: #selector(switchChanged), for: UIControl.Event.valueChanged)

        contentView.addSubview(prefixLabel)
        prefixLabel.pinBelowView(view: titleLabel, constant: Style.Layout.innerSpacing)
        prefixLabel.pinToLeadingAndTrailingMargins()
        prefixLabel.pinToBottomMargin()
    }
    
    private func styleView() {
        titleLabel.font = Style.Font.body
        titleLabel.textColor = .primaryText
        titleLabel.numberOfLines = 0
        prefixLabel.numberOfLines = 0
        switchControl.onTintColor = .primary
        
        titleLabel.text = titleText
        prefixLabel.text = prefixText
    }
    
    // MARK: - Actions
    
    @objc func switchChanged(switch: UISwitch) {
        onSwitchChanged?(switchControl.isOn)
    }
}
