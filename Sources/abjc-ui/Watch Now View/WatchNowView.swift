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
    
    /// DesignConfiguration Environment
    @Environment(\.designConfig) var designConfig
    
    
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
                        if session.preferences.beta_coverRows {
                            CoverRow(nil, self.favoriteItems, session.api.getImageURL, session.preferences)
                                .frame(height: 500)
                        } else {
                            MediaRow("watchnow.favorites", self.favoriteItems, session.api.getImageURL, session.preferences)
                        }
                        Divider()
                    }
                    
                    if self.resumeItems.count != 0 {
                        MediaRow("watchnow.continueWatching", self.resumeItems, session.api.getImageURL, session.preferences)
                        Divider()
                    }
                    
//                    if self.nextUpItems.count != 0 {
//                        MediaRow("watchnow.nextUp", self.nextUpItems, session.api.getImageURL)
//                        Divider()
//                    }
                    
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
        self.favoriteItems = session.items.filter({ $0.userData.isFavorite })
        self.resumeItems = session.items.filter({ $0.userData.playbackPosition > 0})
        
        session.api.getItems { (result) in
            switch result {
                case .success(let items):
                    session.updateItems(items)
                    self.favoriteItems = items.filter({ $0.userData.isFavorite })
                    self.resumeItems = items.filter({ $0.userData.playbackPosition > 0})
                    
                case .failure(let error):
                    DispatchQueue.main.async {
                        session.alert = AlertError("alerts.apierror", error.localizedDescription)
                    }
            }
            
            
        }
        
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
    }
}
