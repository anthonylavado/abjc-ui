//
//  File.swift
//  
//
//  Created by Noah Kamara on 11.11.20.
//

//struct AuthView: View {
//    var body: some View {
//        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//    }
//}
//
//struct AuthView_Previews: PreviewProvider {
//    static var previews: some View {
//        AuthView()
//    }
//}

import SwiftUI

import abjc_core
import abjc_api

extension AuthView {
    public struct ServerSelectionView: View {
        
        /// ServerLocator
        private let locator: ServerLocator = ServerLocator()
        
        /// SessionStore EnvironmentObject
        @EnvironmentObject var session: SessionStore
        
        /// DesignConfiguration EnvironmentObject
        @EnvironmentObject var designConfig: DesignConfiguration
        
        
        /// Server Host
        @State var host: String = ""
        
        /// Server Port
        @State var port: String = "8096"
        
        
        
        /// Servers Discovered By ServerLookup
        @State var servers: [ServerLocator.ServerLookupResponse] = []
        
        
        /// ViewBuilder body
        public var body: some View {
            VStack {
                ScrollView([.horizontal]) {
                    LazyHStack(alignment: .center) {
                        NavigationLink(destination: ServerSelectionManual()) {
                            ServerCard("auth.serverselection.manual.label", "auth.serverselection.manual.descr")
                        }
                        
                        ForEach(self.servers, id:\.id) { server in
                            NavigationLink(destination: CredentialEntryView(server.host, server.port)) {
                                ServerCard(server.name, "\(server.host):\(String(server.port))")
                            }
                        }
                    }
                }.onAppear(perform: discover)
            }
            .navigationTitle("auth.serverselection.title")
        }
        
        
        /// Discover Servers
        func discover() {
            locator.locateServer { (server) in
                if server != nil {
                    if !servers.contains(server!) {
                        servers.append(server!)
                    }
                }
            }
        }
    }
    
    struct ServerSelectionView_Previews: PreviewProvider {
        static var previews: some View {
            ServerSelectionView()
        }
    }
}
