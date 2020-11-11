//
//  Itempage.swift
//  
//
//  Created by Noah Kamara on 10.11.20.
//

import SwiftUI

import abjc_core
import abjc_api


struct ItemPage: View {
    
    /// SessionStore EnvironmentObject
    @EnvironmentObject var session: SessionStore
    
    /// Media Item
    private let item: API.Models.Item
    
    
    /// Initializer
    /// - Parameter item: Media Item
    public init(_ item: API.Models.Item) {
        self.item = item
    }
    
    var body: some View {
        Group {
            switch item.type {
                case .movie:  MoviePage(item)
                case .series:  SeriesPage(item)
                default:  EmptyView()
            }
        }
    }
}
