//
//  PersonCardConfiguration.swift
//  
//
//  Created by Noah Kamara on 10.11.20.
//

import Foundation
import CoreGraphics

extension DesignConfiguration {
    public class PersonCard: ObservableObject {
        /// Default Configuration for Apple TV
        public static let atv: PersonCard = PersonCard(size: 300)
        
        /// Default Configuration for iPad
        public static let ios: PersonCard = PersonCard(size: 300)
        
        /// Default Configuration for Mac
        public static let mac: PersonCard = PersonCard(size: 300)
        
        /// Image Size
        public let size: CGFloat
        
        
        /// Initializer
        /// - Parameters:
        ///   - size: Size of the Image
        public init(size: CGFloat) {
            self.size = size
        }
    }
}
