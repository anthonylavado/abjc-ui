//
//  PreferencesServerInfo.swift
//  
//
//  Created by Noah Kamara on 11.11.20.
//

import SwiftUI

import abjc_core
import abjc_api

extension PreferencesView {
    public struct ServerInfo: View {
        
        /// SessionStore EnvironmentObject
        @EnvironmentObject var session: SessionStore
        
        /// DesignConfiguration EnvironmentObject
        @EnvironmentObject var designConfig: DesignConfiguration
        
        public init() {}
        
        
        /// Server SystemInfo
        @State var systemInfo: API.Models.SystemInfo? = nil
        
        /// ViewBuilder body
        public var body: some View {
            Group() {
                if let data = systemInfo {
                    Form() {
                        Section(header: Label("pref.serverinfo.general.label", systemImage: "externaldrive.connected.to.line.below")) {
                            HStack {
                                Text("pref.serverinfo.servername.label")
                                Spacer()
                                Text(data.serverName)
                            }.focusable(true)
                            HStack {
                                Text("pref.serverinfo.version.label")
                                Spacer()
                                Text(data.version)
                            }
                            HStack {
                                Text("pref.serverinfo.id.label")
                                Spacer()
                                Text(data.serverId)
                            }
                            HStack {
                                Text("pref.serverinfo.os.label")
                                Spacer()
                                Text(data.operatingSystemName)
                            }
                            HStack {
                                Text("pref.serverinfo.architecture.label")
                                Spacer()
                                Text(data.systemArchitecture)
                            }
                        }
                        Section(header: Label("pref.serverinfo.networking.label", image: "network")) {
                            HStack {
                                Text("pref.serverinfo.host.label")
                                Spacer()
                                Text(data.host)
                            }
                            HStack {
                                Text("pref.serverinfo.port.label")
                                Spacer()
                                Text(String(data.port))
                            }
                        }
                    }
                } else {
                    ProgressView()
                }
            }.onAppear(perform: load)
        }
        
        
        /// Loads ServerInfo
        func load() {
            session.api.getSystemInfo() { result in
                switch result {
                    case .success(let systemInfo): self.systemInfo = systemInfo
                    case .failure(let error): print(error)
                }
            }
        }
    }
}

