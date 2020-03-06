//
//  UIView+ShowModalView.swift
//  TagBoard
//
//  Created by Will Brandin on 3/5/20.
//  Copyright © 2020 Will Brandin. All rights reserved.
//

import UIKit

public extension UIView {
    /*!
     Presents a ModalView from the window belonging to the current view.
     The view will be presented with a bounce animation while blurring the background.
     
     allowTapOutsideToDismiss allows the user to tap outside the modal to dismiss it.
     The default is true
     */
    func showModalView(view: ModalPresentable, allowUserToDismiss: Bool = true, window: UIWindow? = nil) {
        let presentingWindow = self.window ?? window
        
        let presenter = ModalPresenter(view: view,
                                       allowUserToDismiss: allowUserToDismiss)
        presentingWindow?.addSubview(presenter)
        presenter.setMargins(top: UIApplication.shared.statusBarFrame.height,
                             leading: 0,
                             bottom: safeAreaInsets.bottom,
                             trailing: 0)
        presenter.pinToSuperview()
        presenter.show()
    }
}
