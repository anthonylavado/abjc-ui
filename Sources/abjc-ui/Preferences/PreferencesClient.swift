//
//  PreferencesClient.swift
//
//
//  Created by Noah Kamara on 11.11.20.
//

import SwiftUI

import abjc_core
import abjc_api

extension PreferencesView {
    public struct Client: View {
        
        /// SessionStore EnvironmentObject
        @EnvironmentObject var session: SessionStore
        
        /// DesignConfiguration Environment
        @Environment(\.designConfig) var designConfig
        
        @State var betaflags: Set<PreferenceStore.BetaFlag> = Set<PreferenceStore.BetaFlag>()
        
        var version: Version { session.preferences.version }
        
        public init() {}
        
        
        /// ViewBuilder body
        public var body: some View {
            Form() {
                Section(header: Label("pref.client.tabs.label", systemImage: "photo.fill")) {
                    Toggle("pref.client.tabs.watchnow", isOn: $session.preferences.showingWatchNowTab)
                    Toggle("pref.client.tabs.movies", isOn: $session.preferences.showingMoviesTab)
                    Toggle("pref.client.tabs.series", isOn: $session.preferences.showingSeriesTab)
                    Toggle("pref.client.tabs.search", isOn: $session.preferences.showingSearchTab)
                }
                
                Section(header: Label("pref.client.betaflags.label", systemImage: "exclamationmark.triangle.fill")) {
                    List(PreferenceStore.BetaFlag.availableFlags(), id: \.rawValue) { flag in
                        Button(action: {
                            DispatchQueue.main.async {
                                betaflags.toggle(flag)
                                session.preferences.betaflags.toggle(flag)
                            }
                        }) {
                            HStack(alignment: .firstTextBaseline) {
                                Group() {
                                    if betaflags.contains(flag) {
                                        Image(systemName: "checkmark.circle.fill")
                                            .imageScale(.large)
                                    } else {
                                        Image(systemName: "circle")
                                            .foregroundColor(.clear)
                                    }
                                }
                                VStack(alignment: .leading) {
                                    Text(flag.label)
                                        .font(.headline)
                                        .bold()
                                    Text(flag.description)
                                        .font(.callout)
                                        .foregroundColor(.secondary)
                                }
                            }.padding()
                        }
                    }
                }
                
                HStack {
                    Text("App Version")
                    Text(version.description)
                }
            }
            
            .onAppear() {
                DispatchQueue.main.async {
                    betaflags = session.preferences.betaflags
                }
            }
        }
    }
}

