//
//  File.swift
//  
//
//  Created by Noah Kamara on 11.11.20.
//

import SwiftUI

import abjc_core
import abjc_api

public struct PreferencesView: View {
    
    /// SessionStore EnvironmentObject
    @EnvironmentObject var session: SessionStore
    
    /// DesignConfiguration Environment
    @Environment(\.designConfig) var designConfig
    
    
    /// ListView Selection
    @State var selection: Int? = 0
    
    
    public var body: some View {
        ViewContainer() {
            List(selection: $selection) {
                NavigationLink(destination: ServerInfo()) {
                    Label("pref.serverinfo.label", systemImage: "server.rack")
                }.tag(0)
                
                NavigationLink(destination: Client()) {
                    Label("pref.client.label", systemImage: "tv")
                }.tag(1)
                
                NavigationLink(destination: DebugMenu()) {
                    Label("pref.debugmenu.label", systemImage: "exclamationmark.triangle")
                }.tag(2)
                
                NavigationLink(destination: PreferencesAbout()) {
                    Label("pref.about.label", systemImage: "exclamationmark.bubble")
                }.tag(3)
                
                Button(action: {
                    self.session.clear()
                }) {
                    HStack {
                        Spacer()
                        Text("buttons.logout")
                            .bold()
                            .textCase(.uppercase)
                            .foregroundColor(.red)
                        
                        Spacer()
                    }
                }
            }
        }.navigationViewStyle(DoubleColumnNavigationViewStyle())
    }
}
