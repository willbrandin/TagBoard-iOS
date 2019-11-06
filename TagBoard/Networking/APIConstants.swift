//
//  APIConstants.swift
//  TagBoard
//
//  Created by Will Brandin on 11/4/19.
//  Copyright © 2019 Will Brandin. All rights reserved.
//

import Foundation

struct APIConstants {
    struct EndPoint {
        static let local = "http://localhost:5000/api/"
        static let staging = "https://tagboard-stg.herokuapp.com/api/"
        static let production = ""
    }
    
    struct Users {
        static let users = "users"
        
        static func id(_ user: User) -> String {
            guard let id = user.id else {
                print("User id is nil")
                return ""
            }
            
            return "\(Users.users)/\(id)"
        }
    }
    
    struct TagBoards {
        static let tagBoards = "tag-boards"
        
        static func id(_ tagBoard: TagBoard) -> String {
            guard let id = tagBoard.id else {
                print("TagBoard id is nil")
                return ""
            }
            
            return "\(TagBoards.tagBoards)/\(id)"
        }
    }
}
