//
//  CredentialEntryView.swift
//  
//
//  Created by Noah Kamara on 11.11.20.
//

import SwiftUI

import abjc_core
import abjc_api

struct CredentialEntryView: View {
    
    /// SessionStore EnvironmentObject
    @EnvironmentObject var session: SessionStore
    
    /// DesignConfiguration EnvironmentObject
    @EnvironmentObject var designConfig: DesignConfiguration
    
    /// PlayerStore EnvironmentObject
    @EnvironmentObject var playerStore: PlayerStore
    
    
    /// Server Host
    private let host: String
    
    /// Server Port
    private let port: Int
    
    
    /// Credentials: username
    @State var username: String = ""
    
    /// Credentials: password
    @State var password: String = ""
    
    @State var showingAlert: Bool = false
    
    init(_ host: String, _ port: Int) {
        self.host = host
        self.port = port
    }
    
    var body: some View {
        VStack {
            Group() {
                VStack {
                    Text(session.host)
                        .font(.callout)
                        .foregroundColor(.secondary)
                }
                TextField("auth.credentials.username.label", text: self.$username)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .textContentType(.username)
                SecureField("auth.credentials.password.label", text: self.$password)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .textContentType(.password)
            }.frame(width: 400)
            
            Button(action: authorize) {
                Text("buttons.signin").textCase(.uppercase)
            }
        }
        .navigationTitle("auth.credentials.title")
        .onAppear() {
            _ = session.setServer(self.host, self.port, UUID().uuidString)
        }
    }
    
    
    /// Authorize
    func authorize() {
        let api = session.setServer(self.host, self.port, UUID().uuidString)
        api.authorize(username, password) { (result) in
            switch result {
                case .success(let authResponse):
                    DispatchQueue.main.async {
                        let credentials = ServerLocator.ServerCredential(session.host,
                                                                         session.port,
                                                                         username,
                                                                         password)
                        if let data = try? JSONEncoder().encode(credentials) {
                            _ = KeyChain.save(key: "credentials", data: data)
                        }
                        
                        self.session.user = API.AuthUser(id: authResponse.user.id,
                                                         name: authResponse.user.name,
                                                         serverID: authResponse.serverId,
                                                         deviceID: credentials.deviceId,
                                                         token: authResponse.token)
                        self.playerStore.api = self.session.api
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        if error = API.Errors.ServerError.notFound {
                            session.alert = AlertError("auth.credentials.error.label", "auth.host.error.descr")
                        } else {
                            session.alert = AlertError("auth.credentials.error.label", "auth.credentials.error.descr")
                        }
                    }
            }
        }
    }
}


//struct CredentialEntryView_Previews: PreviewProvider {
//    static var previews: some View {
//        CredentialEntryView()
//    }
//}
