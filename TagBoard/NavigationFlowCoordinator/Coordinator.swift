//
//  Coordinator.swift
//  TagBoard
//
//  Created by Will Brandin on 11/4/19.
//  Copyright © 2019 Will Brandin. All rights reserved.
//

import Foundation

@objc public enum NavigationStyle: Int {
    case present
    case push
    case pushAndMakeRoot
}

public protocol Coordinator: class {
    /// starts coordinator flow
    func start(with presentationStyle: NavigationStyle, animated: Bool)

    /// finish coordinator flow
    func finish()
    
    func start()
}
