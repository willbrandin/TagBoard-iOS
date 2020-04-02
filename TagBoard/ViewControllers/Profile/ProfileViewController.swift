//
//  ProfileViewController.swift
//  TagBoard
//
//  Created by Will Brandin on 4/2/20.
//  Copyright © 2020 Will Brandin. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    // MARK: - Properties
    
    // MARK: - Initializer
    
    deinit {
        print("DEINIT - \(String(describing: self))")
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Profile"
        view.backgroundColor = .background
    }
}
