//
//  MediaCardConfiguration.swift
//  
//
//  Created by Noah Kamara on 10.11.20.
//

import Foundation
import CoreGraphics

extension DesignConfiguration {
    public class MediaCard: ObservableObject {
        /// Default Configuration for Apple TV
        public static let atv: MediaCard = MediaCard(width: 548, 10)
        
        /// Default Configuration for iPad
        public static let pad: MediaCard = MediaCard(width: 300, 10)
        
        /// Default Configuration for iPhone
        public static let fon: MediaCard = MediaCard(width: 300, 10)
        
        /// Media Item Size
        public let size: CGSize
        
        /// Media Item Corner Radius
        public let cornerRadius: CGFloat
        
        
        /// Initializer
        /// - Parameters:
        ///   - size: Size of the Card
        ///   - cornerRadius: Corner Radius
        public init(size: CGSize, _ cornerRadius: CGFloat) {
            self.size = size
            self.cornerRadius = cornerRadius
        }
        
        /// Initializer
        /// - Parameters:
        ///   - width: Width of the Card
        ///   - cornerRadius: Corner Radius
        ///   - aspectRatio: used to calculate height (default: 16/9)
        public init(width: CGFloat, _ cornerRadius: CGFloat, _ aspectRatio: CGFloat = 16 / 9) {
            self.size = CGSize(width: width, height: width * (1 / aspectRatio))
            self.cornerRadius = cornerRadius
        }
        
        /// Initializer
        /// - Parameters:
        ///   - height: Height of the Card
        ///   - cornerRadius: Corner Radius
        ///   - aspectRatio: used to calculate width (default: 16/9)
        public init(height: CGFloat, _ cornerRadius: CGFloat, _ aspectRatio: CGFloat = 16 / 9) {
            self.size = CGSize(width: height * aspectRatio, height: height)
            self.cornerRadius = cornerRadius
        }
    }
}
