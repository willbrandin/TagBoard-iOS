//
//  DividerView.swift
//  TagBoard
//
//  Created by Will Brandin on 3/5/20.
//  Copyright © 2020 Will Brandin. All rights reserved.
//

import UIKit

class DividerView: UIView {
    
    // MARK: - Initializer
    
    init() {
        super.init(frame: .zero)
        
        self.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        self.backgroundColor = .secondaryText
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
