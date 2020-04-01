//
//  CloseBarButton.swift
//  TagBoard
//
//  Created by Will Brandin on 4/1/20.
//  Copyright © 2020 Will Brandin. All rights reserved.
//

import UIKit

class CloseBarButton: UIBarButtonItem {
    convenience init(_ target: Any?, action: Selector, image: UIImage, tintColor: UIColor = .primaryText) {
        let button = UIButton(type: .system)
        let tintImage = image.withTintColor(tintColor, renderingMode: .alwaysTemplate)
        button.setImage(tintImage, for: .normal)
        button.addTarget(target, action: action, for: .touchUpInside)
        self.init(customView: button)
    }
}

extension UIViewController {
    func addCloseButton(image: UIImage) {
        let closeButton = CloseBarButton(self, action: #selector(dismissSelf), image: image)
        self.navigationItem.leftBarButtonItem = closeButton
    }
    
    @objc func dismissSelf() {
        self.navigationController?.presentingViewController?.dismiss(animated: true, completion: nil)
    }
}
