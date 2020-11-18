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
    
    /// DesignConfiguration Environment
    @Environment(\.designConfig) var designConfig
    
    /// PlayerStore EnvironmentObject
    @EnvironmentObject var playerStore: PlayerStore

    /// Navigation / Tab Selection
    @State var selection: Int? = 0
    
    
    public init() {}
    
    
    public var body: some View {
        Group() {
            if !session.hasUser || !session.api.hasAddress {
                AuthView()
            } else {
                view
                    .fullScreenCover(item: $playerStore.playItem) {_ in
                        PlayerView().environmentObject(playerStore)
                    }
            }
        }.alert(item: $session.alert) { (alert) -> Alert in
//            if session.preferences.isDebugEnabled {
//                Alert(
//                    title: Text(alert.title),
//                    message: Text(alert.description),
//                    primaryButton: .default(Text("buttons.ok")),
////                    secondaryButton: .
//                )
//            } else {
//                
//            }
            Alert(
                title: Text(alert.title),
                message: Text(alert.description),
                dismissButton: .default(Text("buttons.ok"))
            )
        }
    }
    
    
    #if os(OSX)
    
    /// MacOS MainView
    private var view: some View {
        Text("Mac")
    }
    
    #else
//    if os(iOS)
//    
//    /// iPad MainView
//    private var view: some View {
//        NavigationView() {
//            List(selection: $selection) {
//                if session.preferences.showingWatchNowTab {
//                    NavigationLink(
//                        destination: WatchNowView(),
//                        tag: 0,
//                        selection: $selection,
//                        label: {
//                            Label("main.watchnow.tablabel", systemImage: "square.grid.3x2.fill")
//                        })
//                }
//                if session.preferences.showingMoviesTab {
//                    NavigationLink(
//                        destination: MediaCollection(.movie),
//                        tag: 1,
//                        selection: $selection,
//                        label: {
//                            Label("main.movies.tablabel", systemImage: "square.grid.3x2.fill")
//                        })
//                }
//                
//                if session.preferences.showingSeriesTab {
//                    NavigationLink(
//                        destination: MediaCollection(.series),
//                        tag: 2,
//                        selection: $selection,
//                        label: {
//                            Label("main.shows.tablabel", systemImage: "square.grid.3x2.fill")
//                        })
//                }
//                
//                if session.preferences.showingSearchTab {
//                    NavigationLink(
//                        destination: SearchView(),
//                        tag: 3,
//                        selection: $selection,
//                        label: {
//                            Label("main.search.tablabel", systemImage: "magnifyingglass")
//                        })
//                }
//                NavigationLink(
//                    destination: PreferencesView(),
//                    tag: 4,
//                    selection: $selection,
//                    label: {
//                        Label("main.preferences.tablabel", systemImage: "gear")
//                    })
//            }.listStyle(SidebarListStyle())
//            WatchNowView()
//        }
//    }
//    
//    #elseif os(tvOS)
    
    /// Apple TV MainView
    private var view: some View {
        TabView() {
            if session.preferences.showingWatchNowTab {
                WatchNowView()
                    .tabItem({ Text("main.watchnow.tablabel") })
                    .tag(0)
            }
            if session.preferences.showingMoviesTab {
                MediaCollection(.movie)
                    .tabItem({ Text("main.movies.tablabel") })
                    .tag(1)
            }
            
            if session.preferences.showingSeriesTab {
                MediaCollection(.series)
                    .tabItem({ Text("main.shows.tablabel") })
                    .tag(2)
            }
            
            if session.preferences.showingSearchTab {
                SearchView()
                    .tabItem({
                        Text("main.search.tablabel")
                        Image(systemName: "magnifyingglass")
                    })
                    .tag(3)
            }
        
            PreferencesView()
                .tabItem({ Text("main.preferences.tablabel") })
                .tag(4)
        }
    }
    
    #endif
}

//struct MainViewContainer_Previews: PreviewProvider {
//    static var previews: some View {
//        MainViewContainer()
//    }
//}
