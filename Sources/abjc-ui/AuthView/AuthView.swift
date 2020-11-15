//
//  AuthView.swift
//  
//
//  Created by Noah Kamara on 11.11.20.
//

import SwiftUI

import abjc_core
import abjc_api

struct AuthView: View {
    
    /// SessionStore EnvironmentObject
    @EnvironmentObject var session: SessionStore
    
    /// DesignConfiguration Environment
    @Environment(\.designConfig) var designConfig
    
    /// PlayerStore EnvironmentObject
    @EnvironmentObject var playerStore: PlayerStore
    
    
    /// First Authentification Try failed
    @State var firstTryFailed: Bool = false
    
    
    /// ViewBuilder body
    var body: some View {
        NavigationView() {
            if !firstTryFailed {
                ProgressView()
                    .onAppear(perform: authorize)
            } else {
                ServerSelectionView()
            }
        }.navigationViewStyle(StackNavigationViewStyle())
    }
    
    
    /// Authorize with stored Credentials
    func authorize() {
        if let data = KeyChain.load(key: "credentials") {
            if let credentials = try? JSONDecoder().decode(ServerLocator.ServerCredential.self, from: data) {
                let api = session.setServer(credentials.host, credentials.port, credentials.deviceId)
                api.authorize(credentials.username, credentials.password) { (result) in
                    switch result {
                        case .success(let authResponse):
                            DispatchQueue.main.async {
                                self.session.user = API.AuthUser(id: authResponse.user.id,
                                                                 name: authResponse.user.name,
                                                                 serverID: authResponse.serverId,
                                                                 deviceID: credentials.deviceId,
                                                                 token: authResponse.token)
                                self.playerStore.api = self.session.api
                            }
                        case .failure(let error):
                            self.firstTryFailed.toggle()
                    }
                }
            } else {
                self.firstTryFailed.toggle()
            }
        } else {
            self.firstTryFailed.toggle()
        }
    }
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView()
    }
}




