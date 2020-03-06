//
//  ModalPresenterDelegate.swift
//  TagBoard
//
//  Created by Will Brandin on 3/5/20.
//  Copyright © 2020 Will Brandin. All rights reserved.
//

import Foundation

/// Used internally to the Modal Presenter
protocol PresentableDelegate: class {
    func didTapDismiss(didCancel: Bool)
}
