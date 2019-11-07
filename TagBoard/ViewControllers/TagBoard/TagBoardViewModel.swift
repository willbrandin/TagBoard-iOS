//
//  TagBoardViewModel.swift
//  TagBoard
//
//  Created by Will Brandin on 11/7/19.
//  Copyright © 2019 Will Brandin. All rights reserved.
//

import Foundation

class TagBoardViewModel {
    
    // MARK: - Properties
    
    var onDidUpdateTags: (([String]) -> Void)?
    var onUpdateTitle: ((String) -> Void)?
    
    var tags = [String]() {
        didSet {
            onDidUpdateTags?(tags)
        }
    }
    
    var title: String = "" {
        didSet {
            onUpdateTitle?(title)
        }
    }
    
    // MARK: - Methods
    
    func update(_ title: String) {
        self.title = title
    }
}
