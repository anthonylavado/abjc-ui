//
//  SinglePageView.swift
//  
//
//  Created by Noah Kamara on 28.11.20.
//

import SwiftUI

import abjc_core
import abjc_api

struct SinglePageView: View {
    
    /// SessionStore EnvironmentObject
    @EnvironmentObject var session: SessionStore
    
    /// DesignConfiguration Environment
    @Environment(\.designConfig) var designConfig
    

    /// MediaType
    private let type: API.Models.MediaType?
    
    
    /// array of items (fetched from API)
    @State var items: [API.Models.Item] = []
    
    /// array of favorites items
    @State var favoriteItems: [API.Models.Item] = []
    
    /// array of resumable items
    @State var resumeItems: [API.Models.Item] = []
    
    /// unique array of genres found in `items`
    private var genres: [API.Models.Genre] {
        return items.flatMap({ ($0.genres) }).uniques
    }
    
    
    /// Initializer
    /// - Parameter type: MediaType for API fetch
    public init(_ type: API.Models.MediaType? = nil) {
        self.type = type
    }
    
    var body: some View {
        ViewContainer() {
            ScrollView(.vertical, showsIndicators: true) {
                LazyVStack(alignment: .leading) {
                    if self.favoriteItems.count != 0 {
                        MediaRow("watchnow.favorites", self.favoriteItems, session.api.getImageURL, session.preferences)
                        Divider()
                    }
                    
                    if self.resumeItems.count != 0 {
                        MediaRow("watchnow.continueWatching", self.resumeItems, session.api.getImageURL, session.preferences)
                        Divider()
                    }
                    
                    ForEach(self.genres, id:\.id) { genre in
                        MediaRow(genre.name, items.filter({ $0.genres.contains(genre) }), session.api.getImageURL, session.preferences)
                        Divider()
                    }
                }
            }
        }
        .onAppear(perform: load)
    }
    
    /// Loads Content From API
    func load() {
        self.items = session.items
        
        session.api.getResumable { (result) in
            switch result {
                case .success(let items): self.resumeItems = items
                case .failure(let error):
                    DispatchQueue.main.async {
                        session.alert = AlertError("alerts.apierror", error.localizedDescription)
                    }
            }
        }
        
        
        session.api.getFavorites { (result) in
            switch result {
                case .success(let items): self.favoriteItems = items
                case .failure(let error): session.alert = AlertError("alerts.apierror", error.localizedDescription)
            }
        }
        
        if session.hasUser {
            session.api.getItems() { result in
                switch result {
                    case .success(let items):
                        if self.items != items {
                            self.items = items
                            session.updateItems(items)
                        }
                    case .failure(let error):
                        if session.preferences.isDebugEnabled {
                            DispatchQueue.main.async {
                                session.alert = AlertError("alerts.apierror", error)
                            }
                        } else {
                            DispatchQueue.main.async {
                                session.alert = AlertError("alerts.apierror", error.localizedDescription)
                            }
                        }
                }
            }
        }
    }
}

struct SinglePageView_Previews: PreviewProvider {
    static var previews: some View {
        SinglePageView()
    }
}
