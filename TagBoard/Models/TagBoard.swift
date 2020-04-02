//
//  TagBoard.swift
//  TagBoard
//
//  Created by Will Brandin on 11/5/19.
//  Copyright © 2019 Will Brandin. All rights reserved.
//

import Foundation

struct TagBoard: Codable, Equatable {
    let id: String?
    let title: String
    let tags: [String]
    let createdDate: String?
    let lastUpdatedDate: String?
    
    private enum CodingKeys: String, CodingKey {
        case id = "_id"
        case title, tags, createdDate, lastUpdatedDate
    }
}
