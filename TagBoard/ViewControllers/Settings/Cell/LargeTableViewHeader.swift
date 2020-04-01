//
//  LargeTableViewHeader.swift
//  TagBoard
//
//  Created by Will Brandin on 4/1/20.
//  Copyright © 2020 Will Brandin. All rights reserved.
//

import UIKit

class LargeTableViewHeader: UITableViewHeaderFooterView, CellLoadableView {
    
    // MARK: - Properties
    
    private let titleLabel = UILabel(frame: .zero)
    
    // MARK: - Initializer
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
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
        contentView.setMargins(top: Style.Layout.margin,
                               leading: Style.Layout.innerSpacing,
                               bottom: Style.Layout.margin,
                               trailing: Style.Layout.innerSpacing)
        
        contentView.addSubview(titleLabel)
        titleLabel.pinToMargins()
    }
    
    private func styleView() {
        titleLabel.font = Style.Font.title
        titleLabel.textColor = .primaryText
    }
}
