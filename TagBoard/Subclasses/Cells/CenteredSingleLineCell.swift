//
//  CenteredSingleLineCell.swift
//  TagBoard
//
//  Created by Will Brandin on 4/1/20.
//  Copyright © 2020 Will Brandin. All rights reserved.
//

import UIKit

class CenteredSingleLineCellStyle {
    var textColor: UIColor = .primaryText
    var titleFont: UIFont = Style.Font.bodyBold
    
    init() {}
}

extension CenteredSingleLineCellStyle {
    static var standardStyle: CenteredSingleLineCellStyle {
        return CenteredSingleLineCellStyle()
    }
    
    static var dangerStyle: CenteredSingleLineCellStyle {
        let style = CenteredSingleLineCellStyle()
        style.textColor = .error
        return style
    }
}

class CenteredSingleLineCell: UITableViewCell, CellLoadableView {
    
    // MARK: - Properties
    
    private let titleLabel = UILabel(frame: .zero)
    
    // MARK: - Initializer
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    func setCell(title: String, style: CenteredSingleLineCellStyle) {
        self.titleLabel.text = title
        titleLabel.font = style.titleFont
        titleLabel.textColor = style.textColor
    }
    
    // MARK: - Private Methods
    
    private func setupView() {
        contentView.setMargins(top: Style.Layout.marginXL,
                               leading: Style.Layout.innerSpacing,
                               bottom: Style.Layout.marginXL,
                               trailing: Style.Layout.innerSpacing)
        
        contentView.addSubview(titleLabel)
        titleLabel.pinToMargins()
        titleLabel.textAlignment = .center
    }
}
