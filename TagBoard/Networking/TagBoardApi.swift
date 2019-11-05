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
    case signIn
    
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
        case .signIn:
            return APIConstants.Users.users
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .signIn:
            return .post
        }
    }
    
    var task: HTTPTask {
        switch self {
        case .signIn:
            return .requestParameters(bodyParameters: nil, urlParameters: nil)
        }
    }
    
    var headers: HTTPHeaders? {
        if let token = UserDefaultManager.bearerToken {
            return ["Authorization": "Bearer \(token)"]
        }
        
        return nil
    }
}
