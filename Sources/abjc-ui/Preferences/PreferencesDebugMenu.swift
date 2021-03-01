//
//  PreferencesDebugMenu.swift
//
//
//  Created by Noah Kamara on 11.11.20.
//

import SwiftUI

import abjc_core
import abjc_api

import URLImage


extension PreferencesView {
    public struct DebugMenu: View {
        
        /// SessionStore EnvironmentObject
        @EnvironmentObject var session: SessionStore
        
        /// DesignConfiguration Environment
        @Environment(\.designConfig) var designConfig
        
        public init() {}
        
        
        /// ViewBuilder body
        public var body: some View {
            Form() {
                Toggle("pref.debugmenu.debugmode.label", isOn: $session.preferences.isDebugEnabled)
                
                Section(header: Label("pref.debugmenu.images.label", systemImage: "photo.fill")) {
                    HStack {
                        Text("pref.debugmenu.images.identifier")
                        Spacer()
                        Text(URLImageService.shared.defaultOptions.identifier ?? "ERROR")
                    }
                    
                    HStack {
                        Text("pref.debugmenu.images.cachePolicy")
                        Spacer()
                        Text(URLImageService.shared.defaultOptions.cachePolicy.label())
                    }
                    
                    HStack {
                        Text("pref.debugmenu.images.expiryInterval")
                        Spacer()
                        Text(String(URLImageService.shared.defaultOptions.expiryInterval ?? 0))
                    }
                    
                    Button(action: {
                        URLImageService.shared.cleanup()
                        session.alert = AlertError("alerts.info", "Cache was cleaned")
                    }) {
                        Text("pref.debugmenu.images.cleanupcache")
                            .textCase(.uppercase)
                    }
                    
                    Button(action: {
                        URLImageService.shared.removeAllCachedImages()
                        session.alert = AlertError("alerts.info", "Cache was cleared")
                    }) {
                        Text("pref.debugmenu.images.clearcache")
                            .textCase(.uppercase)
                    }
                }
            }
        }
    }
}


extension URLImageOptions.CachePolicy {
    func label() -> LocalizedStringKey {
        switch self {
            case .ignoreCache: return "pref.debugmenu.images.cachepolicy.ignoreCache"
            case .returnCacheDontLoad: return "pref.debugmenu.images.cachepolicy.returnCacheDontLoad"
            case .returnCacheElseLoad: return "pref.debugmenu.images.cachepolicy.returnCacheElseLoad"
        case .useProtocol: return "pref.debugmenu.images.cachepolicy.useProtocol"
        }
        
    }
}
