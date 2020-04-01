//
//  TagRefineViewModel.swift
//  TagBoard
//
//  Created by Will Brandin on 4/1/20.
//  Copyright © 2020 Will Brandin. All rights reserved.
//

import UIKit

class TagRefineViewModel {
    
    // MARK: - Properties
    
    var onUpdateCount: ((Int) -> Void)?
    
    var title: String {
        return "\(tagCount) Hashtags"
    }
    
    private(set) lazy var tagCount: Int = tagBoards.compactMap({ $0.tags.count }).reduce(0, +)
    private(set) var tagBoards: [TagBoard]
    private(set) var selectedTags: [String]

    private let tags: [String]
    
    // MARK: - Initializer
    
    init(tagBoards: [TagBoard]) {
        self.tagBoards = tagBoards
        self.tags = tagBoards.flatMap({$0.tags})
        self.selectedTags = self.tags
    }
    
    // MARK: - Methods
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let chipCell: ChipCollectionViewCell = collectionView.deqeueReusableCell(for: indexPath)
        let tag = tags[indexPath.row]
        chipCell.setCellContent(title: tag)
        
        chipCell.isSelected = selectedTags.contains(tag)
        if chipCell.isSelected {
            collectionView.selectItem(at: indexPath, animated: true, scrollPosition: [])
        }
        
        return chipCell
    }
    
    func didSelect(at index: Int) {
        let tag = tags[index]
        selectedTags.append(tag)
        onUpdateCount?(selectedTags.count)
    }
    
    func didDeselect(at index: Int) {
        let tag = tags[index]
        guard let tagboard = selectedTags.first(where: { $0 == tag }),
            let index = selectedTags.firstIndex(of: tagboard) else {
            return
        }
        
        selectedTags.remove(at: index)
        onUpdateCount?(selectedTags.count)
    }
}
