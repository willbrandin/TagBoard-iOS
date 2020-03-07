//
//  ModalPresentable.swift
//  TideSpinConsumer
//
//  Created by Will Brandin on 3/3/20.
//  Copyright © 2020 Tide Laundry Services. All rights reserved.
//

import UIKit

/// A base class for Modal Views to be presented with Modal Presenter
open class ModalPresentable: UIView {
    
    // MARK: - Properties
    
    weak var modalDelegate: PresentableDelegate?
    public let presentableStyle: ModalPresentableStyle
    public let presenterStyle: ModalPresenterStyle
    
    // MARK: - Initializer
    
    required public init(style: ModalPresentableStyle, presenterStyle: ModalPresenterStyle) {
        self.presentableStyle = style
        self.presenterStyle = presenterStyle
        super.init(frame: .zero)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    public func dismiss(didCancel: Bool = false) {
        modalDelegate?.didTapDismiss(didCancel: didCancel)
    }
    
    func roundTopCorners(cornerRadius: Double) {
        self.layer.cornerRadius = CGFloat(cornerRadius)
        self.clipsToBounds = true
        self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
}

public class ModalPresentableStyle {
    
    public init() {}
    
    public var handleVisible: Bool = false
    public var handleSize: CGSize = CGSize(width: 30, height: 4)
    public var handleColor: UIColor = .secondaryText
    public var handleInset: CGFloat = CGFloat(10)
    public var contentOuterMargins: CGFloat = Style.Layout.margin
    /// The color of the underlay that stretched under the top or bottom bar and is fitted in size to the content view.
    public var contentBackgroundColor: UIColor = UIColor.clear
}

public extension ModalPresentableStyle {
    /// Standard Modal Style - The ModalPresentable determins background color and no handle is shown.
    static var standardStyle: ModalPresentableStyle {
        return ModalPresentableStyle()
    }
    
    /// Handle Style - The Content View has a Light Background and a handle is displayed for dismissing is user dismall is allowed.
    static var handleStyle: ModalPresentableStyle {
        let style = ModalPresentableStyle()
        style.handleVisible = true
        style.contentOuterMargins = 0
        style.contentBackgroundColor = .background
        return style
    }
    
    /// Handle Style - The Content View has no background color and a handle is displayed for dismissing is user dismall is allowed.
    static var floatingHandleStyle: ModalPresentableStyle {
        let style = ModalPresentableStyle()
        style.handleVisible = true
        style.contentOuterMargins = 0
        return style
    }
    
    static var noHandleFullWidth: ModalPresentableStyle {
        let style = ModalPresentableStyle()
        style.contentOuterMargins = 0
        style.contentBackgroundColor = .background
        return style
    }
    
    static var clearStyle: ModalPresentableStyle {
        let style = ModalPresentableStyle()
        style.contentOuterMargins = 0
        style.contentBackgroundColor = .clear
        return style
    }
}
