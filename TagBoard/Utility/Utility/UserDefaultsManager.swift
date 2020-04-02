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
    private static let loggedInUserInfoKey = "loggedInUserInfoKey"
    
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
    
    static var user: User? {
        get {
            if let savedAccount = UserDefaults.standard.object(forKey: loggedInUserInfoKey) as? Data {
                let decoder = JSONDecoder()
                if let loadedAccount = try? decoder.decode(User.self, from: savedAccount) {
                    return loadedAccount
                } else {
                    return nil
                }
            } else {
                return nil
            }
        }
        set {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(newValue) {
                let defaults = UserDefaults.standard
                defaults.set(encoded, forKey: loggedInUserInfoKey)
            }
        }
    }
}
