//
//  TBHomeListViewModel.swift
//  TagBoard
//
//  Created by Will Brandin on 11/6/19.
//  Copyright © 2019 Will Brandin. All rights reserved.
//

import UIKit
import RocketNetworking

class TBHomeListViewModel {
    
    // MARK: - Properties
    
    var onIsLoading: ((Bool) -> Void)?
    var onDataSourceUpdated: (() -> Void)?
    var onTapDisclosure: ((TagBoard) -> Void)?
    var onDisplayCopyButton: ((Bool) -> Void)?
    
    let numberOfSections = 1
    
    var numberOfRows: Int {
        return tagBoards.count
    }
    
    private var tagBoards = [TagBoard]() {
        didSet {
            onDataSourceUpdated?()
            
            if !selectedBoards.isEmpty {
                selectedBoards = [TagBoard]()
            }
        }
    }
    
    private(set) var selectedBoards = [TagBoard]() {
        didSet {
            onDisplayCopyButton?(!selectedBoards.isEmpty)
        }
    }
    
    // MARK: - Methods
    
    func requestList() {
        print("GETTING DATA")
        onIsLoading?(true)
        
        NetworkManager.sharedInstance.request(for: .getTagBoards, [TagBoard].self) { [weak self] result in
            DispatchQueue.main.async {
                self?.handleFetch(result: result)
            }
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
    
    func didUpdate(_ tag: TagBoard) {
        if let tagboard = tagBoards.first(where: { $0.id == tag.id }),
            let index = tagBoards.firstIndex(of: tagboard) {
            tagBoards[index] = tag
            onDataSourceUpdated?()
        } else {
            tagBoards.append(tag)
        }
    }
    
    func didSelect(at index: Int) {
        let tag = tagBoards[index]
        selectedBoards.append(tag)
    }
    
    func didDeselect(at index: Int) {
        let tag = tagBoards[index]
        guard let tagboard = selectedBoards.first(where: { $0.id == tag.id }),
            let index = selectedBoards.firstIndex(of: tagboard) else {
            return
        }
        
        selectedBoards.remove(at: index)
    }
    
    // MARK: - Private Methods
    
    private func handleFetch(result: Result<[TagBoard], APIError>) {
        onIsLoading?(false)
        
        switch result {
        case .success(let tags):
            self.tagBoards = tags
            
        case .failure(let error):
            print(error)
        }
    }
}
