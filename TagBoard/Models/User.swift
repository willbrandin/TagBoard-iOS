//
//  User.swift
//  TagBoard
//
//  Created by Will Brandin on 11/5/19.
//  Copyright © 2019 Will Brandin. All rights reserved.
//

import Foundation

struct User: Codable {
    let id: String?
    let name: String?
    let email: String?
    let userIdentifier: String
}

extension User {
    /// Create a New user during sign up.
    init(name: String, email: String, identifier: String) {
        self.init(id: nil, name: name, email: email, userIdentifier: identifier)
    }
}
