//
//  EnvironmentValues.swift
//  
//
//  Created by Noah Kamara on 10.11.20.
//

import SwiftUI


public extension EnvironmentValues {
    var designConfig: DesignConfiguration {
        get { self[DesignConfiguration.self] }
        set { self[DesignConfiguration.self] = newValue }
    }
}
