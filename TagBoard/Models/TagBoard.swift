//
//  TagBoard.swift
//  TagBoard
//
//  Created by Will Brandin on 11/5/19.
//  Copyright © 2019 Will Brandin. All rights reserved.
//

import Foundation

struct TagBoard: Codable {
    let id: String?
    let title: String
    let tags: [String]
    let createdDate: String?
    let lastUpdatedDate: String?
}
