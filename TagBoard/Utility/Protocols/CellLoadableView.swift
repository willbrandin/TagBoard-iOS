//
//  CellLoadableView.swift
//  TideSpinConsumer
//
//  Created by Will Brandin on 2/13/20.
//  Copyright © 2020 Tide Laundry Services. All rights reserved.
//

import UIKit

protocol CellLoadableView: class {
    static var cellName: String { get }
}

extension CellLoadableView where Self: UIView {
    static var cellName: String {
        return String(describing: self)
    }
}
