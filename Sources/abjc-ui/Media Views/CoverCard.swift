//
//  File.swift
//  
//
//  Created by Noah Kamara on 10.03.21.
//

import SwiftUI
import URLImage

import abjc_core
import abjc_api


/// CoverCard
/// Shows
public struct CoverCard: View {
    
    /// Image URL
    private let url: URL
    
    /// DesignConfiguration Environment
    @Environment(\.designConfig) var designConfig
    
    /// Reference to DesignConfiguration > CoverCard > Height
    private var height: CGFloat { designConfig.coverCard.height }
    
    /// Reference to DesignConfiguration > MediaCard > Size
    private var cornerRadius: CGFloat { designConfig.coverCard.cornerRadius }
    
    
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
        GeometryReader() { geo in
            ZStack(alignment: .leading) {
                background
                HStack {
                    image
                        .clipShape(RoundedRectangle(cornerRadius: cornerRadius * 1.5, style: .continuous))
                        .padding()
                    info.padding()
                }
            }
            .clipped()
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
        }.frame(height: height)
    }
    
    
    /// Info View
    private var info: some View {
        VStack(alignment: .center) {
            Spacer()
            Text(item.name)
                .bold()
                .font(.title2)
            
            HStack {
                Spacer()
                if item.year != nil {
                    Label(String(item.year!), systemImage: "calendar.circle.fill").labelStyle(InfoLabelStyle())
                }
                Label(String(format: "%.0f", Float(item.runTime / 600)), systemImage: "clock.fill").labelStyle(InfoLabelStyle())
                if item.userData.isFavorite {
                    Label("favorite", systemImage: "star.circle.fill").labelStyle(InfoLabelStyle())
                }
                Spacer()
            }.foregroundColor(.secondary)
            Spacer()
        }
    }
    
    /// Background View
    private var background: some View {
        ZStack {
            placeholder
            Blur()
        }
    }
    
    /// Placeholder for loading URLImage
    private var placeholder: some View {
        Image(uiImage: UIImage(blurHash: self.item.blurHash(for: .backdrop) ?? self.item.blurHash(for: .primary) ?? "", size: CGSize(width: 32, height: 16)) ?? UIImage())
            .renderingMode(.original)
            .resizable()
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
        }.aspectRatio(16/9, contentMode: .fit)
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
            }.frame(width: geo.size.width, height: geo.size.width)
        }
    }
    
    
    struct InfoLabelStyle: LabelStyle {
        func makeBody(configuration: Configuration) -> some View {
            HStack(spacing: 5) {
                configuration.icon
                configuration.title
            }
        }
    }
}
