//
//  LeadingDisclosureCell.swift
//  TagBoard
//
//  Created by Will Brandin on 4/2/20.
//  Copyright © 2020 Will Brandin. All rights reserved.
//

import UIKit

class LeadingDisclosureCell: UITableViewCell, CellLoadableView {
    
    // MARK: - Properties
    
    private let titleLabel = UILabel(frame: .zero)
    private let disclsureImageView = UIImageView(image: .chevronRight)
    
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
    
    func setCell(title: String) {
        self.titleLabel.text = title
    }
    
    // MARK: - Private Methods
    
    private func setupView() {
        contentView.setMargins(top: Style.Layout.marginXL,
                               leading: Style.Layout.innerSpacing,
                               bottom: Style.Layout.marginXL,
                               trailing: Style.Layout.innerSpacing)
        
        contentView.addSubview(titleLabel)
        titleLabel.pinToTopMargin()
        titleLabel.pinToBottomMargin()
        titleLabel.pinToLeadingMargin()
        
        contentView.addSubview(disclsureImageView)
        disclsureImageView.alignVerticalCenterToView(view: titleLabel)
        disclsureImageView.pinToTrailingMargin()
    }
    
    private func styleView() {
        titleLabel.font = Style.Font.bodyBold
        disclsureImageView.contentMode = .scaleAspectFit
        disclsureImageView.tintColor = .systemGray2
    }
}
