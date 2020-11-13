//
//  WatchNowView.swift
//
//
//  Created by Noah Kamara on 11.11.20.
//

import SwiftUI

import abjc_core
import abjc_api

public struct WatchNowView: View {
    
    /// SessionStore EnvironmentObject
    @EnvironmentObject var session: SessionStore
    
    /// DesignConfiguration EnvironmentObject
    @EnvironmentObject var designConfig: DesignConfiguration
    
    
    /// array of favorite items (fetched from API)
    @State var favoriteItems: [API.Models.Item] = []
    
    /// array of resumable items (fetched from API)
    @State var resumeItems: [API.Models.Item] = []
    
    /// array of next up items (fetched from API)
    @State var nextUpItems: [API.Models.Item] = []
    
    /// array of latest items (fetched from API)
    @State var latestItems: [API.Models.Item] = []
    
    
    public var body: some View {
        ViewContainer() {
            ScrollView(.vertical, showsIndicators: true) {
                VStack(alignment: .leading) {
                    if self.favoriteItems.count != 0 {
                        MediaRow("watchnow.favorites", self.favoriteItems, session.api.getImageURL)
                        Divider()
                    }
                    
                    if self.resumeItems.count != 0 {
                        MediaRow("watchnow.continueWatching", self.resumeItems, session.api.getImageURL)
                        Divider()
                    }
                    
                    if self.nextUpItems.count != 0 {
                        MediaRow("watchnow.nextUp", self.nextUpItems, session.api.getImageURL)
                        Divider()
                    }
                    
//                    if !latestItems.filter({$0.type == .movie}).isEmpty {
//                        MediaRow("watchnow.latestMovies", self.latestItems.filter({$0.type == .movie}))
//                        Divider()
//                    }
//                    
//                    if !latestItems.filter({$0.type == .series}).isEmpty {
//                        MediaRow("watchnow.latestShows", self.latestItems.filter({$0.type == .series}))
//                        Divider()
//                    }
                }
            }
        }
        .onAppear(perform: load)
    }
    
    func load() {
        session.api.getResumable { (result) in
            switch result {
                case .success(let items): self.resumeItems = items
                case .failure(let error):
                    DispatchQueue.main.async {
                        session.alert = AlertError("alerts.apierror", error.localizedDescription)
                    }
            }
        }
        
//        session.api.getNextUp { (result) in
//            switch result {
//                case .success(let items): self.nextUpItems = items
//                case .failure(let error):
//                    DispatchQueue.main.async {
//                        session.alert = AlertError("alerts.apierror", error.localizedDescription)
//                    }
//            }
//        }
        
        session.api.getLatest() { (result) in
            switch result {
                case .success(let items): self.latestItems = items
                case .failure(let error):
                    print(error)
                    session.alert = AlertError("alerts.apierror", error.localizedDescription)
            }
        }
        
        session.api.getFavorites { (result) in
            switch result {
                case .success(let items): self.favoriteItems = items
                case .failure(let error): session.alert = AlertError("alerts.apierror", error.localizedDescription)
            }
        }
    }
}
