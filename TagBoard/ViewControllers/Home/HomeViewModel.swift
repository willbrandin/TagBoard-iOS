//
//  HomeViewModel.swift
//  TagBoard
//
//  Created by Will Brandin on 11/6/19.
//  Copyright © 2019 Will Brandin. All rights reserved.
//

import Foundation

class HomeViewModel {
    
    // MARK: - Properties
    
    var onIsLoading: ((Bool) -> Void)?
    var onDataSourceChanged: (([TagBoard]) -> Void)?
    
    private var tagBoards = [TagBoard]() {
        didSet {
            onDataSourceChanged?(tagBoards)
        }
    }
    
    // MARK: - Initializer
    
    init() {}
    
    // MARK: - Methods
    
    
    func addNew(_ board: TagBoard) {
        self.tagBoards.append(board)
    }
    
    func delete(at index: Int) {
        self.tagBoards.remove(at: index)
    }
    
    func tagBaord(for index: Int) -> TagBoard? {
        return tagBoards[index]
    }
}
