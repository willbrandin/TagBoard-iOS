//
//  UIViewController+LoadingView.swift
//  RickyBobby
//
//  Created by Eyal Zohar on 10/10/18.
//  Copyright © 2018 Tide University Laundry. All rights reserved.
//

import Foundation
import UIKit

protocol LoadingView {
    func showLoadingView()
    func hideLoadingView()
}

extension LoadingView where Self: UIViewController {
    private var tag: Int {
        return 684
    }
    
    func hideLoadingView() {
        
        guard let window = UIApplication.shared.delegate?.window ?? UIApplication.shared.keyWindow else {
            return
        }
        
        window.viewWithTag(tag)?.removeFromSuperview()
    }
    
    func showLoadingView() {
        
        guard let window = UIApplication.shared.delegate?.window ?? UIApplication.shared.keyWindow, window.viewWithTag(tag) == nil else {
            return
        }
        
        let loadingView = UIView(frame: window.frame)
        loadingView.backgroundColor = .clear
        loadingView.addSubview(indicatorView(window: window))
        loadingView.tag = tag
        window.addSubview(loadingView)
    }
    
    func indicatorView(window: UIWindow) -> UIView {
        
        let indicatorView = UIActivityIndicatorView(style: .whiteLarge)
        indicatorView.startAnimating()
        
        let activityContainerView = UIView(frame: CGRect(x: 0, y: 0, width: 75.0, height: 75.0))
        activityContainerView.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        activityContainerView.layer.cornerRadius = 4.0
        
        activityContainerView.addSubview(indicatorView)
        indicatorView.center = CGPoint(x: activityContainerView.center.x, y: activityContainerView.center.y)

        activityContainerView.center = CGPoint(x: window.center.x, y: window.center.y)
        
        return activityContainerView
    }
}
