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
    
    /// DesignConfiguration EnvironmentObject
    @EnvironmentObject var designConfig: DesignConfiguration
    

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
    
    
    /// ViewBuilder body
    public var body: some View {
        ViewContainer() {
            ScrollView(.vertical, showsIndicators: true) {
                LazyVStack(alignment: .leading) {
                    ForEach(self.genres, id:\.id) { genre in
                        MediaRow(genre.name, items.filter({ $0.genres.contains(genre) }), session.api.getImageURL)
                        Divider()
                    }
                }
            }
        }
        .onAppear(perform: load)
    }
    
    
    /// Loads Content From API
    func load() {
        if session.hasUser {
            session.api.getItems(type) { result in
                switch result {
                    case .success(let items):
                        self.items = items
                    case .failure(let error):
                        DispatchQueue.main.async {
                            session.alert = AlertError("alerts.apierror", error.localizedDescription)
                        }
                }
            }
        }
    }
}

struct MediaCollection_Previews: PreviewProvider {
    static var previews: some View {
        MediaCollection(.movie)
        MediaCollection(.series)
    }
}
