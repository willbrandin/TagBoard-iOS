//
//  CoordinatorsTracker.swift
//  TagBoard
//
//  Created by Will Brandin on 11/4/19.
//  Copyright © 2019 Will Brandin. All rights reserved.
//

import Foundation

public protocol CoordinatorsTracker {
    /// gives a chance to track the coordinator reference in a custom way
    ///
    /// - Parameter coordinator: coordinator to track
    func track(coordinator: Coordinator)
}
