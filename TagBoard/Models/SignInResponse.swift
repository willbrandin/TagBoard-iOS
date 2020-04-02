//
//  SignInResponse.swift
//  TagBoard
//
//  Created by Will Brandin on 4/2/20.
//  Copyright © 2020 Will Brandin. All rights reserved.
//

import Foundation

struct SignIn: Codable {
    let token: String
    let user: User
}
