//
//  InitialConfiguration.swift
//  TagBoard
//
//  Created by Will Brandin on 11/4/19.
//  Copyright © 2019 Will Brandin. All rights reserved.
//

import Foundation
import RocketNetworking

extension AppDelegate {
    func configureNetworkLayer() {
        guard let environment = NetworkEnvironment(rawValue: BundleUtil.buildEnvironment) else {
            print("Networking Layer could not be configured.")
            return
        }
        
        print("LAUNCHING IN \(environment)")
        NetworkManager.setEnvironment(for: environment)
    }
}
