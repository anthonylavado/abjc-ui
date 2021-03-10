//
//  CoverCardConfiguration.swift
//
//
//  Created by Noah Kamara on 10.11.20.
//

import Foundation
import CoreGraphics

extension DesignConfiguration {
    public class CoverCard: ObservableObject {
        /// Default Configuration for Apple TV
        public static let atv: CoverCard = CoverCard(400, 10)
        
        /// Default Configuration for iOS
        public static let ios: CoverCard = CoverCard(400, 10)
        
        /// Default Configuration for Mac
        public static let mac: CoverCard = CoverCard(400, 10)
        
        /// Media Item Corner Radius
        public let cornerRadius: CGFloat
        
        public let height: CGFloat
        
        
        /// Initializer
        /// - Parameters:
        ///   - height: Height of Card
        ///   - cornerRadius: Corner Radius
        public init(_ height: CGFloat = 400, _ cornerRadius: CGFloat) {
            self.height = height
            self.cornerRadius = cornerRadius
        }
    }
}
