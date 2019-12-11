//
//  LandingViewModel.swift
//  TagBoard
//
//  Created by Will Brandin on 12/11/19.
//  Copyright © 2019 Will Brandin. All rights reserved.
//

import Foundation
import AuthenticationServices

@available(iOS 13.0, *)
class LandingViewModel {
    
    // MARK: - Closures
    
    var onIsLoading: ((Bool) -> Void)?
    var onComplete: (() -> Void)?
    var onFailed: ((Error) -> Void)?
    
    // MARK: - Properties
    
    let title: String = "Sign in to begin organizing all of your hashtags in one place."
    let authorizationScopes: [ASAuthorization.Scope] = [.fullName, .email]
    
    // MARK: - Methods
    
    func requestSignIn(with credential: ASAuthorizationAppleIDCredential) {
        print(credential)
        onComplete?()
    }
    
    func authorizationDidFail(with error: Error) {
        print("COULD NOT GET CREDENTIALS -- \(error.localizedDescription)")
        onFailed?(error)
    }
}
