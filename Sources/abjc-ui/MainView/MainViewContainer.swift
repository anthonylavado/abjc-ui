//
//  MainViewContainer.swift
//  
//
//  Created by Noah Kamara on 10.11.20.
//

import SwiftUI

import abjc_core
import abjc_api

public struct MainViewContainer: View {
    
    /// SessionStore EnvironmentObject
    @EnvironmentObject var session: SessionStore
    
    /// DesignConfiguration EnvironmentObject
    @EnvironmentObject var designConfig: DesignConfiguration
    
    /// PlayerStore EnvironmentObject
    @EnvironmentObject var playerStore: PlayerStore

    /// Navigation / Tab Selection
    @State var selection: Int? = 0
    
    
    public init() {}
    
    
    public var body: some View {
        Group() {
            if session.hasUser {
                view
            } else {
                AuthView()
            }
        }
    }
    
    
    #if os(OSX)
    
    /// MacOS MainView
    private var view: some View {
        Text("Mac")
    }
    
    #elseif os(iOS)
    
    /// iPad MainView
    private var view: some View {
        NavigationView() {
            List() {
                if session.preferences.showingWatchNowTab {
                    NavigationLink(
                        destination: Text("WatchNowView")/*WatchNowView(false)*/,
                        tag: 0,
                        selection: $selection,
                        label: {
                            Label("main.watchnow.tablabel", systemImage: "square.grid.3x2.fill")
                        })
                }
                if session.preferences.showingMoviesTab {
                    NavigationLink(
                        destination: MediaCollection(.movie),
                        tag: 1,
                        selection: $selection,
                        label: {
                            Label("main.movies.tablabel", systemImage: "square.grid.3x2.fill")
                        })
                }
                
                if session.preferences.showingSeriesTab {
                    NavigationLink(
                        destination: MediaCollection(.series),
                        tag: 2,
                        selection: $selection,
                        label: {
                            Label("main.shows.tablabel", systemImage: "square.grid.3x2.fill")
                        })
                }
                
                if session.preferences.showingSearchTab {
                    NavigationLink(
                        destination: Text("SearchView") /*SearchView(false)*/,
                        tag: 3,
                        selection: $selection,
                        label: {
                            Label("main.search.tablabel", systemImage: "magnifyingglass")
                        })
                }
                NavigationLink(
                    destination: Text("PreferencesView") /*PreferencesView()*/,
                    tag: 4,
                    selection: $selection,
                    label: {
                        Label("main.preferences.tablabel", systemImage: "magnifyingglass")
                    })
            }.listStyle(SidebarListStyle())
        }
    }
    
    #elseif os(tvOS)
    
    /// Apple TV MainView
    private var view: some View {
        Text("Apple TV")
    }
    
    #endif
}

//struct MainViewContainer_Previews: PreviewProvider {
//    static var previews: some View {
//        MainViewContainer()
//    }
//}
