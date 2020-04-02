//
//  User.swift
//  TagBoard
//
//  Created by Will Brandin on 11/5/19.
//  Copyright © 2019 Will Brandin. All rights reserved.
//

import Foundation
import AuthenticationServices

struct User: Codable {
    let id: String?
    let firstName: String?
    let lastName: String?
    let email: String?
    let userCredential: String // Can not be null
    
    
    private enum CodingKeys: String, CodingKey {
        case id = "_id"
        case firstName, lastName, email, userCredential
    }
}

extension User {
    init(authorization credential: ASAuthorizationAppleIDCredential) {
        self.id = nil
        self.firstName = credential.fullName?.givenName
        self.lastName = credential.fullName?.familyName
        self.email = credential.email
        self.userCredential = credential.user
    }
}

extension User {
    var fullName: String {
        guard let firstName = firstName, let lastName = lastName else {
            return ""
        }
        
        return "\(firstName) \(lastName)"
    }
}
