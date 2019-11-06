//
//  TBHomeListViewModel.swift
//  TagBoard
//
//  Created by Will Brandin on 11/6/19.
//  Copyright © 2019 Will Brandin. All rights reserved.
//

import UIKit

class TBHomeListViewModel {
    
    // MARK: - Properties
    
    var onDataSourceUpdated: (() -> Void)?
    
    let numberOfSections = 1
    
    var numberOfRows: Int {
        return tagBaords.count
    }
    
    private var tagBaords = [TagBoard]() {
        didSet {
            onDataSourceUpdated?()
        }
    }
    
    // MARK: - Methods
    
    func injectDataSource(_ tagBoards: [TagBoard]) {
        self.tagBaords = tagBoards
    }
    
    func cellForRow(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = tagBaords[indexPath.row].title
        return cell
    }
}
