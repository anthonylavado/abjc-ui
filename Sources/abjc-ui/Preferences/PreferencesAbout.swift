//
//  PreferencesAbout.swift
//  
//
//  Created by Noah Kamara on 18.11.20.
//

import SwiftUI

import abjc_core


struct PreferencesAbout: View {
    
    /// SessionStore EnvironmentObject
    @EnvironmentObject var session: SessionStore
    
    /// DesignConfiguration Environment
    @Environment(\.designConfig) var designConfig
    
    var version: Version { session.preferences.version }
    
    public init() {}
    
    
    /// ViewBuilder body
    public var body: some View {
        Form() {
            Section(header: Label("pref.about.label", systemImage: "photo.fill")) {
                HStack {
                    Text("Twitter")
                    Spacer()
                    Text("@abjc_app")
                }.focusable(true)
                HStack {
                    Text("Email")
                    Spacer()
                    Text("developer@noahkamara.com")
                }.focusable(true)
            }
        }
        
        .navigationTitle("pref.about.label")
    }
}

struct PreferencesAbout_Previews: PreviewProvider {
    static var previews: some View {
        PreferencesAbout()
    }
}
