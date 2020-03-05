//
//  LandingViewController.swift
//  TagBoard
//
//  Created by Will Brandin on 12/11/19.
//  Copyright © 2019 Will Brandin. All rights reserved.
//

import UIKit
import AuthenticationServices

class LandingViewController: UIViewController, LoadingView {
    
    // MARK: - Closures
    
    var onComplete: (() -> Void)?
    
    // MARK: - Properties
    
    private var viewModel: LandingViewModel = LandingViewModel()
    
    private let logoView = UIImageView(image: .logo)
    private let titleLabel = UILabel(frame: .zero)
    
    private let button = ASAuthorizationAppleIDButton(authorizationButtonType: .signIn,
                                                      authorizationButtonStyle: .white)
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .primary
        view.setMargins(top: Style.Layout.marginXL,
                        leading: Style.Layout.marginXL,
                        bottom: Style.Layout.marginXL,
                        trailing: Style.Layout.marginXL + Style.Layout.innerSpacing)
        
        view.addSubview(logoView)
        logoView.pinToTop(constant: 48)
        logoView.pinToHorizontalCenter()
        logoView.heightAnchor.constraint(equalToConstant: 64).isActive = true
        
        logoView.contentMode = .scaleAspectFit
        
        view.addSubview(button)
        button.pinToBottomMargin()
        button.pinToHorizontalCenter()
        button.widthAnchor.constraint(greaterThanOrEqualToConstant: Style.Layout.maxButtonWidth).isActive = true
        button.heightAnchor.constraint(equalToConstant: Style.Layout.buttonHeight).isActive = true
        
        button.cornerRadius = 4
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        view.addSubview(titleLabel)
        titleLabel.pinAboveView(view: button, constant: 48)
        titleLabel.pinToLeadingAndTrailingMargins()
        
        titleLabel.font = Style.Font.h1
        titleLabel.textColor = .white
        titleLabel.text = viewModel.title
        titleLabel.numberOfLines = 0
        
        subscribeToViewModel()
    }
    
    // MARK: - Private Methods
    
    private func subscribeToViewModel() {
        viewModel.onIsLoading = { [weak self] isLoading in
            if isLoading {
                self?.showLoadingView()
            } else {
                self?.hideLoadingView()
            }
        }
        
        viewModel.onFailed = { error in
            print("FAILED - \(error.localizedDescription)")
        }
        
        viewModel.onComplete = onComplete
    }
    
    // MARK: - Actions
    
    @objc private func buttonTapped() {
        #if DEBUG
        onComplete?()
        #else
        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = viewModel.authorizationScopes

        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.performRequests()
        #endif
    }
}

extension LandingViewController: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        
        guard let credential = authorization.credential as? ASAuthorizationAppleIDCredential else {
            return
        }
        
        viewModel.requestSignIn(with: credential)
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        viewModel.authorizationDidFail(with: error)
    }
}
