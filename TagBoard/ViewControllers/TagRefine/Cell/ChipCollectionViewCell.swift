//
//  ChipCollectionViewCell.swift
//  TagBoard
//
//  Created by Will Brandin on 4/1/20.
//  Copyright © 2020 Will Brandin. All rights reserved.
//

import UIKit

private typealias ChipStyle = Style.ChipCollectionCellStyle
class ChipCollectionViewCell: UICollectionViewCell, CellLoadableView {
    
    // MARK: - Properties
    
    override var isSelected: Bool {
        didSet {
            contentView.backgroundColor = isSelected ? ChipStyle.selectedColor : ChipStyle.deselectedColor
        }
    }
    
    private let title = UILabel(frame: .zero)
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentView.leftAnchor.constraint(equalTo: leftAnchor),
            contentView.rightAnchor.constraint(equalTo: rightAnchor),
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        setupView()
        styleView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    func setCellContent(title: String) {
        self.title.text = title
        contentView.backgroundColor = isSelected ? ChipStyle.selectedColor : ChipStyle.deselectedColor
    }

    // MARK: - Private Methods
    
    private func setupView() {
        contentView.layer.cornerRadius = ChipStyle.cornerRadius
        contentView.setMargins(top: ChipStyle.topMargin,
                               leading: Style.Layout.innerSpacing,
                               bottom: ChipStyle.topMargin,
                               trailing: Style.Layout.innerSpacing)
        
        contentView.addSubview(title)
        title.pinToMargins()
    }
    
    private func styleView() {
        title.font = Style.Font.caption
        title.textAlignment = .center
    }
}
