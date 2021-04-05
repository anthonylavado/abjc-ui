//
//  File.swift
//  
//
//  Created by Noah Kamara on 10.03.21.
//

import SwiftUI

import abjc_core
import abjc_api

public struct CoverRow: View {
    
    /// DesignConfiguration Environment
    @Environment(\.designConfig) var designConfig
    
    /// Reference to DesignConfiguration > MediaRow > Padding
    private var edgeInsets: EdgeInsets { designConfig.mediaRow.edgeInsets }
    
    
    /// Reference to DesignConfiguration > MediaRow > Spacing
    private var spacing: CGFloat { designConfig.mediaRow.spacing }
    
    
    /// Row Label
    private var label: LocalizedStringKey?
    
    /// Row Items
    private var items: [API.Models.Item]
    
    
    private let imageURL: (String, API.Models.ImageType, Int?, Int?) -> URL
    
    /// Preferences
    private let prefs: PreferenceStore
    
    /// Initializer
    /// - Parameters:
    ///   - label: Row Label
    ///   - items: Row Items
    public init(_ label: String?, _ items: [API.Models.Item], _ imageURL: @escaping (String, API.Models.ImageType, Int?, Int?) -> URL, _ prefs: PreferenceStore) {
        self.label = label != nil ? LocalizedStringKey(label!) : nil
        self.items = items
        self.imageURL = imageURL
        self.prefs = prefs
    }
    
    /// Initializer
    /// - Parameters:
    ///   - label: Localized Row Label
    ///   - items: Row Items
    public init(_ label: LocalizedStringKey?, _ items: [API.Models.Item], _ imageURL: @escaping (String, API.Models.ImageType, Int?, Int?) -> URL, _ prefs: PreferenceStore) {
        self.label = label
        self.items = items
        self.imageURL = imageURL
        self.prefs = prefs
    }
    
    /// ViewBuilder body
    public var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            if label != nil {
                Text(label!)
                    .font(.title3)
                    .padding(.horizontal, edgeInsets.leading)
            }
            TabView {
                ForEach(items, id:\.id) { item in
                    #if os(tvOS)
                    NavigationLink(destination: ItemPage(item)) {
                        CoverCard(item, imageURL(item.id, .backdrop, nil, nil), prefs)
                    }
                    .buttonStyle(PlainButtonStyle())
                    #else
                    NavigationLink(destination: ItemPage(item)) {
                        MediaCard(item, imageURL(item.id, .backdrop, nil, nil), prefs)
                    }
                    #endif
                }.padding(edgeInsets)
            }
            .tabViewStyle(PageTabViewStyle())
            .edgesIgnoringSafeArea(.horizontal)
        }.edgesIgnoringSafeArea(.horizontal)
    }
}
