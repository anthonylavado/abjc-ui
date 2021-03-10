//
//  MediaCollection.swift
//  
//
//  Created by Noah Kamara on 10.11.20.
//

import SwiftUI
import URLImage

import abjc_core
import abjc_api

/// CollectionView for ItemType Collections
public struct MediaCollection: View {
    
    /// SessionStore EnvironmentObject
    @EnvironmentObject var session: SessionStore
    
    /// DesignConfiguration Environment
    @Environment(\.designConfig) var designConfig
    

    /// MediaType
    private let type: API.Models.MediaType?
    
    
    /// array of items (fetched from API)
    @State var items: [API.Models.Item] = []
    
    /// unique array of genres found in `items`
    private var genres: [API.Models.Genre] {
        return items.flatMap({ ($0.genres) }).uniques
    }
    
    
    /// Initializer
    /// - Parameter type: MediaType for API fetch
    public init(_ type: API.Models.MediaType? = nil) {
        self.type = type
    }
    
    @State var groupOption: Int = 0
    @State var sortReversed: Bool = false
    
    /// ViewBuilder body
    public var body: some View {
        ViewContainer() {
            ScrollView(.vertical, showsIndicators: true) {
                VStack(alignment: .leading) {
                    ForEach(self.genres, id:\.id) { genre in
                        MediaRow(genre.name, items.filter({ $0.genres.contains(genre) }), session.api.getImageURL, session.preferences)
                        Divider()
                    }
                }
            }
        }
        .onAppear(perform: load)
        .onDisappear(perform: unload)
    }
    
    
    /// Loads Content From API
    func load() {
        self.items = session.items.filter({$0.type == type})
        if session.hasUser {
            session.api.getItems(type) { result in
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
    
    
    func unload() {
        DispatchQueue.main.async {
            self.items = []
        }
    }
}

struct MediaCollection_Previews: PreviewProvider {
    static var previews: some View {
        MediaCollection(.movie)
        MediaCollection(.series)
    }
}
