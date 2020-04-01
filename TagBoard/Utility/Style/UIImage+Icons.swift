//
//  UIImage+Icons.swift
//  TagBoard
//
//  Created by Will Brandin on 12/11/19.
//  Copyright © 2019 Will Brandin. All rights reserved.
//

import UIKit

extension UIImage {
    static let logo = UIImage(named: "Logo")!
    
    static var checkMarkFill: UIImage {
        let config = UIImage.SymbolConfiguration(textStyle: .headline)
        return UIImage(systemName: "checkmark.circle.fill", withConfiguration: config)!
    }
    
    static var circle: UIImage {
        let config = UIImage.SymbolConfiguration(textStyle: .headline)
        return UIImage(systemName: "circle", withConfiguration: config)!
    }
    
    static var ellipsis: UIImage {
        let config = UIImage.SymbolConfiguration(textStyle: .headline)
        return UIImage(systemName: "ellipsis.circle", withConfiguration: config)!
    }
    
    static var close: UIImage {
        let config = UIImage.SymbolConfiguration(textStyle: .body)
        return UIImage(systemName: "xmark", withConfiguration: config)!
    }
    
    static var gear: UIImage {
        let config = UIImage.SymbolConfiguration(textStyle: .body)
        return UIImage(systemName: "gear", withConfiguration: config)!
    }
    
    static var plus: UIImage {
        let config = UIImage.SymbolConfiguration(textStyle: .body)
        return UIImage(systemName: "plus", withConfiguration: config)!
    }
}
