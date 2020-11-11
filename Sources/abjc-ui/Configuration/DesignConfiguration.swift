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
    
    /// Default Configuration for iPad
    public static let pad: DesignConfiguration = DesignConfiguration(.pad)
    
    /// Default Configuration for iPhone
    public static let fon: DesignConfiguration = DesignConfiguration(.fon)
    
    
    /// MediaRow Configuration
    @Published public var mediaRow: MediaRow
    
    /// MediaCard Configuration
    @Published public var mediaCard: MediaCard
    
    /// PeopleRow Configuration
    @Published public var peopleRow: PeopleRow
    
    /// PersonCard Configuration
    @Published public var personCard: PersonCard
    
    /// EpisodeRow Configuration
    @Published public var episodeRow: EpisodeRow
    
    /// EpisodeCard Configuration
    @Published public var episodeCard: EpisodeCard
    
    
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
            case .pad:
                self.mediaRow       = .pad
                self.mediaCard      = .pad
                self.peopleRow      = .pad
                self.personCard     = .pad
                self.episodeRow     = .pad
                self.episodeCard    = .pad
            case .fon:
                self.mediaRow       = .fon
                self.mediaCard      = .fon
                self.peopleRow      = .fon
                self.personCard     = .fon
                self.episodeRow     = .fon
                self.episodeCard    = .fon
        }
    }
    public init(
        _ mediaRow: MediaRow,
        _ mediaCard: MediaCard,
        _ peopleRow: PeopleRow,
        _ personCard: PersonCard,
        _ episodeRow: EpisodeRow,
        _ episodeCard: EpisodeCard
    ) {
        self.mediaRow       = mediaRow
        self.mediaCard      = mediaCard
        self.peopleRow      = peopleRow
        self.personCard     = personCard
        self.episodeRow     = episodeRow
        self.episodeCard    = episodeCard
    }
    
    /// DeviceType
    public enum Device {
        /// Apple TC
        case atv
        
        /// iPad
        case pad
        
        /// iPhone
        case fon
    }
}
