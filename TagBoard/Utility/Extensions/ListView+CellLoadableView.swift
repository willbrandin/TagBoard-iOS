//
//  ListView+CellLoadableView.swift
//  TagBoard
//
//  Created by Will Brandin on 3/5/20.
//  Copyright © 2020 Will Brandin. All rights reserved.
//

import UIKit

extension UITableView {
    func register<T: UITableViewCell>(_: T.Type) where T: CellLoadableView {
        register(T.self, forCellReuseIdentifier: T.cellName)
    }
    
    func register<T: UITableViewHeaderFooterView>(_:T.Type) where T: CellLoadableView {
        register(T.self, forHeaderFooterViewReuseIdentifier: T.cellName)
    }
    
    func deqeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T where T: CellLoadableView {
        guard let cell = dequeueReusableCell(withIdentifier: T.cellName, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.cellName)")
        }
        
        return cell
    }
    
    func deqeueReusableHeaderFooter<T: UITableViewHeaderFooterView>() -> T where T: CellLoadableView {
        guard let headerFooter = dequeueReusableHeaderFooterView(withIdentifier: T.cellName) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.cellName)")
        }
        
        return headerFooter
    }
}

extension UICollectionView {
    func register<T: UICollectionViewCell>(_: T.Type) where T: CellLoadableView {
        register(T.self, forCellWithReuseIdentifier: T.cellName)
    }
    
    func register<T: UICollectionReusableView>(_: T.Type, ofKind kind: String) where T: CellLoadableView {
        register(T.self, forSupplementaryViewOfKind: kind, withReuseIdentifier: T.cellName)
    }
    
    func deqeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T where T: CellLoadableView {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.cellName, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.cellName)")
        }
        
        return cell
    }
    
    func dequeueReusableSupplementaryView<T: UICollectionReusableView>(ofKind kind: String, for indexPath: IndexPath) -> T where T: CellLoadableView {
        guard let cell = dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: T.cellName, for: indexPath) as? T else {
            fatalError("Couldn't find UICollectionReusableView for \(String(describing: T.cellName))")
        }
        
        return cell
    }
}
