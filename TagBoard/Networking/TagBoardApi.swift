//
//  TagBoardApi.swift
//  TagBoard
//
//  Created by Will Brandin on 11/4/19.
//  Copyright © 2019 Will Brandin. All rights reserved.
//

import Foundation
import RocketNetworking

struct NetworkManager {
    static let sharedInstance = RocketNetworkManager<TagBoardApi>()
    
    static func setEnvironment(for environment: NetworkEnvironment) {
        NetworkManager.sharedInstance.setupNetworkLayer(in: environment)
    }
}

enum TagBoardApi: EndPointType {
    case signInUser(User)
    case updateUser(User)
    case addTagBoard(TagBoard)
    case deleteTagBoard(id: String)
    case updateTagBoard(TagBoard)
    case getTagBoards
    
    var environmentBaseURL: String {
        switch NetworkManager.sharedInstance.environment {
        case .local:
            return APIConstants.EndPoint.local
            
        case .staging:
            return APIConstants.EndPoint.staging
            
        case .production:
            return APIConstants.EndPoint.production
            
        default:
            return ""
        }
    }
    
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("base url could not be config") }
        return url
    }
    
    var path: String {
        switch self {
        case .signInUser:
            return APIConstants.Users.users
            
        case .updateUser(let user):
            return APIConstants.Users.id(user)
            
        case .addTagBoard, .getTagBoards:
            return APIConstants.TagBoards.tagBoards
            
        case .updateTagBoard(let board):
            return APIConstants.TagBoards.id(board)
            
        case .deleteTagBoard(id: let id):
            return "\(APIConstants.TagBoards.tagBoards)/\(id)"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .signInUser, .addTagBoard:
            return .post
            
        case .deleteTagBoard:
            return .delete
            
        case .updateTagBoard, .updateUser:
            return .put
            
        case .getTagBoards:
            return .get
        }
    }
    
    var task: HTTPTask {
        switch self {
        case .signInUser(let user), .updateUser(let user):
            return .requestParameters(bodyParameters: user, urlParameters: nil)
            
        case .addTagBoard(let board), .updateTagBoard(let board):
            return .requestParameters(bodyParameters: board, urlParameters: nil)
            
        case .getTagBoards, .deleteTagBoard:
            return .request
        }
    }
    
    var headers: HTTPHeaders? {
        if let token = UserDefaultsManager.bearerToken {
            return ["Authorization": "Bearer \(token)"]
        }
        
        return nil
    }
}
