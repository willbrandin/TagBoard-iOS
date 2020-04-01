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
    
    var title: String {
        didSet {
            onUpdateTitle?(title)
        }
    }
    
    var saveButtonTitle: String {
        return tagBoard.id != nil ? "Update" : "Save"
    }
    
    private var tagBoard: TagBoard
    
    // MARK: - Initializer
    
    init(tagBoard: TagBoard) {
        self.tagBoard = tagBoard
        self.title = tagBoard.title
        self.tags = tagBoard.tags
    }
    
    // MARK: - Methods
    
    func update(_ title: String) {
        self.title = title
    }
    
    func save() -> TagBoard {
        let updated = TagBoard(id: tagBoard.id, title: title, tags: tags, createdDate: tagBoard.createdDate, lastUpdatedDate: tagBoard.lastUpdatedDate)
        return updated
    }
}
