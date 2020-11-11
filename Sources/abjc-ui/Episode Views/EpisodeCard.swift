//
//  EpisodeCard.swift
//  abjc_design
//
//  Created by Noah Kamara on 10.11.20.
//

import SwiftUI
import URLImage

import abjc_core
import abjc_api

public struct EpisodeCard: View {
    
    /// SessionStore EnvironmentObject
    @EnvironmentObject var session: SessionStore
    
    /// DesignConfiguration EnvironmentObject
    @EnvironmentObject var designConfig: DesignConfiguration
    
    /// Reference to DesignConfiguration > MediaCard > Size
    private var size: CGSize { designConfig.mediaCard.size }
    
    /// Reference to DesignConfiguration > MediaCard > Size
    private var cornerRadius: CGFloat { designConfig.mediaCard.cornerRadius }
    
    
    /// Item
    var item: API.Models.Episode
    
    
    /// Initializer
    /// - Parameter item: Item
    public init(_ item: API.Models.Episode) {
        self.item = item
    }
    
    
    
    /// ViewBuilder body
    public var body: some View {
        ZStack {
            blur
            image
        }
        .aspectRatio(16/9, contentMode: .fill)
        .clipped()
        .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
        .frame(width: size.width, height: size.height)
        .overlay(overlay, alignment: .bottom)
    }
        
    
    /// Placeholder for loading URLImage
    private var placeholder: some View {
        Image(uiImage: UIImage(blurHash: self.item.blurHash(for: .backdrop) ?? self.item.blurHash(for: .primary) ?? "", size: CGSize(width: 32, height: 32)) ?? UIImage())
            .renderingMode(.original)
            .resizable()
    }
    
    
    /// Placeholder for missing URLImage
    private var blur: some View {
        Blur()
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
    }
    
    /// URLImage
    private var image: some View {
        URLImage(
            url: session.api.getImageURL(for: item.id, .backdrop),
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
            if session.preferences.beta_playbackContinuation && item.userData.playbackPosition != 0 {
                ZStack(alignment: .leading) {
                    Capsule()
                    Capsule()
//                        .frame(width: (geo.size.width-40) * CGFloat(item.userData.playbackPosition / item.runTime))
                }.frame(height: 10).padding(20)
            }
        }.frame(width: size.width, height: size.height)
    }
}

