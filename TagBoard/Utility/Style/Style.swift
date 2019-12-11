//
//  Style.swift
//  TagBoard
//
//  Created by Will Brandin on 11/7/19.
//  Copyright © 2019 Will Brandin. All rights reserved.
//

import UIKit

struct Style {
    
    struct Font {
        static let h1 = UIFont.systemFont(ofSize: 24, weight: .bold)
        static let body = UIFont.systemFont(ofSize: 16)
    }
    
    struct Layout {
        /// 12
        static let margin: CGFloat = 12
        /// 24
        static let marginXL: CGFloat = 24
        /// 8
        static let innerSpacing: CGFloat = 8
        /// 48
        static let buttonHeight: CGFloat = 48
        /// 336
        static let maxButtonWidth: CGFloat = 336
    }
}
