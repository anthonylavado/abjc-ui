//
//  MediaItem.swift
//  abjc_design
//
//  Created by Noah Kamara on 10.11.20.
//

import SwiftUI
import URLImage

import abjc_core
import abjc_api


/// MediaCard
/// Shows
public struct MediaCard: View {
    
    /// Image URL
    private let url: URL
    
    /// DesignConfiguration Environment
    @Environment(\.designConfig) var designConfig
    
    /// Reference to DesignConfiguration > MediaCard > Size
    private var size: CGSize { designConfig.mediaCard.size }
    
    /// Reference to DesignConfiguration > MediaCard > Size
    private var cornerRadius: CGFloat { designConfig.mediaCard.cornerRadius }
    
    
    /// Item
    private let item: API.Models.Item
    
    private let prefs: PreferenceStore
    
    /// Initializer
    /// - Parameter item: Item
    public init(_ item: API.Models.Item, _ url: URL, _ prefs: PreferenceStore) {
        self.item = item
        self.url = url
        self.prefs = prefs
    }
    
    
    /// ViewBuilder body
    public var body: some View {
        VStack {
            ZStack {
                blur
                if !prefs.beta_uglymode {
                    placeholder
                    image
                }
            }
            .aspectRatio(16/9, contentMode: .fill)
            .clipped()
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
            .frame(width: size.width, height: size.height)
            .overlay(overlay, alignment: .bottom)
            if prefs.beta_showsTitles {
                HStack(alignment: .top) {
                    Text(item.name)
                        .bold()
                }.frame(width: size.width, height: 90)
            }
        }
    }
    
    
    /// Placeholder for loading URLImage
    private var placeholder: some View {
        #if os(macOS)
        Image(nsImage: NSImage(blurHash: self.item.blurHash(for: .backdrop) ?? self.item.blurHash(for: .primary) ?? "", size: CGSize(width: 8, height: 8)) ?? NSImage())
            .renderingMode(.original)
            .resizable()
        #else
        Image(uiImage: UIImage(blurHash: self.item.blurHash(for: .backdrop) ?? self.item.blurHash(for: .primary) ?? "", size: CGSize(width: 8, height: 8)) ?? UIImage())
            .renderingMode(.original)
            .resizable()
        #endif
        
    }
    
    
    /// Placeholder for missing URLImage
    private var blur: some View {
        Blur()
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
            .overlay(
                VStack {
                    Text(item.name)
                        .font(.headline)
                    Text(item.year != nil ? "(" + String(item.year!) + ")" : "")
                }.padding()
            )
    }
    
    /// URLImage
    private var image: some View {
        URLImage(
            url: url,
            empty: { placeholder },
            inProgress: { _ in placeholder },
            failure:  { _,_ in placeholder }
        ) { image in
                image
                    .renderingMode(.original)
                    .resizable()
        }
    }
    
    
    /// PlaybackPosition Overlay
    private var overlay: some View {
        GeometryReader() { geo in
            VStack {
                Spacer()
                if(item.runTimeTicks != nil) && item.userData.playbackPosition != 0 {
                    ZStack(alignment: .leading) {
                        Blur()
                            .clipShape(Capsule())
                        Capsule()
                            .frame(width: (geo.size.width-40) * CGFloat(Double(item.userData.playbackPositionTicks) / Double(item.runTimeTicks!)))
                            .padding(1)
                    }.frame(height: 10).padding(20)
                }
            }
        }.frame(width: size.width, height: size.height)
    }
}


