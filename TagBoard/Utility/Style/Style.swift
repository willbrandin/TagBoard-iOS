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
        static var title: UIFont {
            let font = UIFont.systemFont(ofSize: 24, weight: .bold)
            let fontMetrics = UIFontMetrics(forTextStyle: .title1)
            return fontMetrics.scaledFont(for: font)
        }
        
        static var headline: UIFont {
            let font = UIFont.systemFont(ofSize: 16, weight: .bold)
            let fontMetrics = UIFontMetrics(forTextStyle: .headline)
            return fontMetrics.scaledFont(for: font)
        }
        
        static var body: UIFont {
            let font = UIFont.systemFont(ofSize: 16)
            let fontMetrics = UIFontMetrics(forTextStyle: .body)
            return fontMetrics.scaledFont(for: font)
        }
        
        static var bodyBold: UIFont {
            let font = UIFont.systemFont(ofSize: 16, weight: .bold)
            let fontMetrics = UIFontMetrics(forTextStyle: .body)
            return fontMetrics.scaledFont(for: font)
        }
        
        static var caption: UIFont {
            let font = UIFont.systemFont(ofSize: 14)
            let fontMetrics = UIFontMetrics(forTextStyle: .caption1)
            return fontMetrics.scaledFont(for: font)
        }
    }
    
    struct Layout {
        // 8
        static let innerSpacing: CGFloat = 8
        /// 12
        static let margin: CGFloat = 12
        /// 24
        static let marginXL: CGFloat = 24
        /// 48
        static let buttonHeight: CGFloat = 48
        /// 64
        static let cellHeight: CGFloat = 64
        /// 336
        static let maxButtonWidth: CGFloat = 336
    }
}
