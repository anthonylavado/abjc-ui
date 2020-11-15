//
//  EpisodeRow.swift
//  
//
//  Created by Noah Kamara on 10.11.20.
//

import SwiftUI
import URLImage

import abjc_core
import abjc_api


/// EpisodeRow
public struct EpisodeRow: View {
    
    /// SessionStore EnvironmentObject
    @EnvironmentObject var session: SessionStore
    
    /// DesignConfiguration Environment
    @Environment(\.designConfig) var designConfig
    
    /// Reference to DesignConfiguration > MediaRow > Padding
    private var edgeInsets: EdgeInsets { designConfig.mediaRow.edgeInsets }
    
    
    /// Reference to DesignConfiguration > MediaRow > Spacing
    private var spacing: CGFloat { designConfig.mediaRow.spacing }
    
    
    /// selected episode
    @Binding var selectedEpisode: API.Models.Episode?
    
    
    /// season label
    private var label: LocalizedStringKey
    
    
    /// Episodes
    private var items: [API.Models.Episode]
    
    
    /// Initializer
    /// - Parameters:
    ///   - label: Label
    ///   - items: Episodes
    ///   - selection: selected Episode
    public init(_ label: String, _ items: [API.Models.Episode], _ selection: Binding<API.Models.Episode?>) {
        self.label = LocalizedStringKey(label)
        self.items = items
        self._selectedEpisode = selection
    }
    
    /// Initializer
    /// - Parameters:
    ///   - label: Label
    ///   - items: Episodes
    ///   - selection: selected Episode
    public init(_ label: LocalizedStringKey, _ items: [API.Models.Episode], _ selection: Binding<API.Models.Episode?>) {
        self.label = label
        self.items = items
        self._selectedEpisode = selection
    }
    
    
    /// ViewBuilder body
    public var body: some View {
        VStack(alignment: .leading) {
            Text(label)
                .font(.title3)
                .padding(.horizontal, edgeInsets.leading)
            ScrollView(.horizontal) {
                LazyHStack(spacing: spacing) {
                    ForEach(items, id:\.id) { item in
                        VStack {
                            Button(action: {
                                selectedEpisode = item
                            }) {
                                EpisodeCard(item)
                            }
                            Text("Episode \(item.index ?? 0)")
                                .font(.callout)
                                .foregroundColor(.secondary)
                            Text(item.name)
                                .bold()
                                .frame(width: 548)
                        }
                    }
                }
                .padding(edgeInsets)
            }
        }
    }
}
