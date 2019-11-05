//
//  BundleUtil.swift
//  TagBoard
//
//  Created by Will Brandin on 11/4/19.
//  Copyright © 2019 Will Brandin. All rights reserved.
//

import Foundation

class BundleUtil {
    
    static var buildEnvironment: Int {
        guard let buildModeString = Bundle.main.infoDictionary!["BUILD_ENVIRONMENT"] as? String,
            let buildMode = Int(buildModeString) else {
            fatalError()
        }
        
        return buildMode
    }
}
