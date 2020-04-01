//
//  ChipCollectionViewCell+Style.swift
//  TagBoard
//
//  Created by Will Brandin on 4/1/20.
//  Copyright © 2020 Will Brandin. All rights reserved.
//

import UIKit

extension Style {
    struct ChipCollectionCellStyle {
        static let cornerRadius: CGFloat = Style.Layout.innerSpacing / 2
        static let topMargin: CGFloat = Style.Layout.innerSpacing / 2
        static let selectedColor: UIColor = .primaryTertiary
        static let deselectedColor: UIColor = .tertiaryBackground
    }
}
