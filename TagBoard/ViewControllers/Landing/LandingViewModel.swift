//
//  LandingViewModel.swift
//  TagBoard
//
//  Created by Will Brandin on 12/11/19.
//  Copyright © 2019 Will Brandin. All rights reserved.
//

import Foundation
import AuthenticationServices
import RocketNetworking

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
    
    func requestSignIn(for user: User) {
        NetworkManager.sharedInstance.request(for: .signInUser(user), SignIn.self) { [weak self] result in
            DispatchQueue.main.async {
                self?.handleSignInResult(result: result)
            }
        }
    }
    
    func authorizationDidFail(with error: Error) {
        print("COULD NOT GET CREDENTIALS -- \(error.localizedDescription)")
        onFailed?(error)
    }
    
    // MARK: - Private Methods
    
    private func handleSignInResult(result: Result<SignIn, APIError>) {
        switch result {
        case .success(let signInResponse):
            print(signInResponse)
            UserDefaultsManager.bearerToken = signInResponse.token
            UserDefaultsManager.user = signInResponse.user
            onComplete?()
            
        case .failure(let apiError):
            authorizationDidFail(with: apiError)
        }
    }
}
