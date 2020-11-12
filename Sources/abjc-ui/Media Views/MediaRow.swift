//
//  SwiftUIView.swift
//  
//
//  Created by Noah Kamara on 10.11.20.
//

import SwiftUI

import abjc_core
import abjc_api

public struct MediaRow: View {
    
    /// SessionStore EnvironmentObject
    @EnvironmentObject var session: SessionStore
    
    /// DesignConfiguration EnvironmentObject
    @EnvironmentObject var designConfig: DesignConfiguration
    
    /// Reference to DesignConfiguration > MediaRow > Padding
    private var edgeInsets: EdgeInsets { designConfig.mediaRow.edgeInsets }
    
    
    /// Reference to DesignConfiguration > MediaRow > Spacing
    private var spacing: CGFloat { designConfig.mediaRow.spacing }
    
    
    /// Row Label
    private var label: LocalizedStringKey
    
    /// Row Items
    private var items: [API.Models.Item]
    
    
    /// Initializer
    /// - Parameters:
    ///   - label: Row Label
    ///   - items: Row Items
    public init(_ label: String, _ items: [API.Models.Item]) {
        self.label = LocalizedStringKey(label)
        self.items = items
    }
    
    /// Initializer
    /// - Parameters:
    ///   - label: Localized Row Label
    ///   - items: Row Items
    public init(_ label: LocalizedStringKey, _ items: [API.Models.Item]) {
        self.label = label
        self.items = items
    }
    
    /// ViewBuilder body
    public var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(label)
                .font(.title3)
                .padding(.horizontal, edgeInsets.leading)
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: spacing) {
                    ForEach(items, id:\.id) { item in
                        #if os(tvOS)
                        NavigationLink(destination: ItemPage(item)) {
                            MediaCard(item)
                        }
                        .buttonStyle(PlainButtonStyle())
                        #else
                        NavigationLink(destination: ItemPage(item)) {
                            MediaCard(item)
                        }
                        #endif
                    }
                }
                .padding(edgeInsets)
            }.edgesIgnoringSafeArea(.horizontal)
        }.edgesIgnoringSafeArea(.horizontal)
    }
}

//struct MediaRow_Previews: PreviewProvider {
//    static var previews: some View {
//        MediaRow()
//    }
//}
