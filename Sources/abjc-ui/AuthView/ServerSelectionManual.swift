//
//  SwiftUIView.swift
//  
//
//  Created by Noah Kamara on 11.11.20.
//

import SwiftUI

struct ServerSelectionManual: View {
    
    /// Server Host
    @State var host: String = "michaels.dynv6.net"
    
    /// Server Port
    @State var port: String = "8096"
    
    
    var body: some View {
        VStack {
            Group() {
                TextField("auth.serverselection.host.label", text: self.$host)
                TextField("auth.serverselection.port.label", text: self.$port)
                    .textContentType(.oneTimeCode)
                    .keyboardType(.numberPad)
            }.frame(width: 400)
            
            NavigationLink(destination: CredentialEntryView(self.host, Int(self.port) ?? 8096)) {
                Text("buttons.continue").textCase(.uppercase)
            }
        }
    }
}

struct ServerSelectionManual_Previews: PreviewProvider {
    static var previews: some View {
        ServerSelectionManual()
    }
}
