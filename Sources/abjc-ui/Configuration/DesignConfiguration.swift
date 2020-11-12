//
//  File.swift
//  
//
//  Created by Noah Kamara on 10.11.20.
//

import Foundation
import CoreGraphics

public class DesignConfiguration: ObservableObject {
    
    /// Default Configuration for Apple TV
    public static let atv: DesignConfiguration = DesignConfiguration(.atv)
    
    /// Default Configuration for iOS
    public static let ios: DesignConfiguration = DesignConfiguration(.ios)
    
    /// Default Configuration for iPhone
    public static let mac: DesignConfiguration = DesignConfiguration(.mac)
    
    
    /// MediaRow Configuration
    public var mediaRow: MediaRow
    
    /// MediaCard Configuration
    public var mediaCard: MediaCard
    
    /// PeopleRow Configuration
    public var peopleRow: PeopleRow
    
    /// PersonCard Configuration
    public var personCard: PersonCard
    
    /// EpisodeRow Configuration
    public var episodeRow: EpisodeRow
    
    /// EpisodeCard Configuration
    public var episodeCard: EpisodeCard
    
    
    /// Navigation Style
    public var navStyle: NavigationStyle
    
    
    /// Initalize Default Configuration for Device Type
    /// - Parameter device: Device Type
    public init(_ device: Device) {
        switch device {
            case .atv:
                self.mediaRow       = .atv
                self.mediaCard      = .atv
                self.peopleRow      = .atv
                self.personCard     = .atv
                self.episodeRow     = .atv
                self.episodeCard    = .atv
                self.navStyle       = .tabs
            case .ios:
                self.mediaRow       = .ios
                self.mediaCard      = .ios
                self.peopleRow      = .ios
                self.personCard     = .ios
                self.episodeRow     = .ios
                self.episodeCard    = .ios
                self.navStyle       = .stacked
            case .mac:
                self.mediaRow       = .mac
                self.mediaCard      = .mac
                self.peopleRow      = .mac
                self.personCard     = .mac
                self.episodeRow     = .mac
                self.episodeCard    = .mac
                self.navStyle       = .sidebar
        }
    }
    public init(
        _ mediaRow: MediaRow,
        _ mediaCard: MediaCard,
        _ peopleRow: PeopleRow,
        _ personCard: PersonCard,
        _ episodeRow: EpisodeRow,
        _ episodeCard: EpisodeCard,
        _ navStyle: NavigationStyle
    ) {
        self.mediaRow       = mediaRow
        self.mediaCard      = mediaCard
        self.peopleRow      = peopleRow
        self.personCard     = personCard
        self.episodeRow     = episodeRow
        self.episodeCard    = episodeCard
        self.navStyle       = navStyle
    }
    
    /// DeviceType
    public enum Device {
        /// Apple TV
        case atv
        
        /// iOS
        case ios
        
        /// Mac
        case mac
    }
    
    
    /// NavigationStyle
    public enum NavigationStyle {
        /// MainViewContainer is TabView
        case tabs
        
        /// MainViewContainer is NavigationView with Sidebar
        case sidebar
        
        /// MainViewContainer is NavigationView without Sidebar
        case stacked
    }
}
