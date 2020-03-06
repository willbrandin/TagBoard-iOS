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
    
    var onIsLoading: ((Bool) -> Void)?
    var onDataSourceUpdated: (() -> Void)?
    var onTapDisclosure: ((TagBoard) -> Void)?
    
    let numberOfSections = 1
    
    var numberOfRows: Int {
        return tagBoards.count
    }
    
    private var tagBoards = [TagBoard]() {
        didSet {
            onDataSourceUpdated?()
        }
    }
    
    // MARK: - Methods
    
    func requestList() {
        print("GETTING DATA")
        onIsLoading?(true)
        var list = [TagBoard]()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.onIsLoading?(false)
            for i in 0..<5 {
                let board = TagBoard(id: "\(i)", title: "TAG - \(i)", tags: ["Hello", "Hie"], createdDate: "2019-07-07", lastUpdatedDate: nil)
                list.append(board)
            }
            
            print("INJECTED")
            self.tagBoards = list
        }
    }
    
    func addNew(_ board: TagBoard) {
        self.tagBoards.append(board)
    }
    
    func delete(_ board: TagBoard) {
        self.tagBoards.removeAll(where: { $0 == board })
    }
    
    func cellForRow(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TagListItemCell = tableView.deqeueReusableCell(for: indexPath)
        let tagBoard = tagBoards[indexPath.row]
        
        let disclosureAction: () -> Void = { [weak self] in
            self?.onTapDisclosure?(tagBoard)
        }
        
        let content = TagListItemContent(title: tagBoard.title, detail: "\(tagBoard.tags.count) Hashtags", disclosureAction: disclosureAction)
        
        cell.selectionStyle = .none
        cell.setCellContent(content)
        return cell
    }
}
