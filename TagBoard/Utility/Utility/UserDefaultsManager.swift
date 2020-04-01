//
//  UserDefaultsManager.swift
//  TagBoard
//
//  Created by Will Brandin on 11/4/19.
//  Copyright © 2019 Will Brandin. All rights reserved.
//

import Foundation

struct UserDefaultsManager {
    
    // MARK: - Keys
    
    private static let bearerTokenKey = "bearerTokenKey"
    private static let isAddingPrefixKey = "isAddingPrefixKey"
    
    // MARK: - Stored Values
    
    static var bearerToken: String? {
        get {
            if let value = UserDefaults.standard.string(forKey: bearerTokenKey) {
                return value
            }
            
            return nil
        }
        set {
            UserDefaults.standard.set(newValue, forKey: bearerTokenKey)
        }
    }
    
    static var isAddingPrefix: Bool {
        get {
            return UserDefaults.standard.bool(forKey: isAddingPrefixKey)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: isAddingPrefixKey)
        }
    }
}
