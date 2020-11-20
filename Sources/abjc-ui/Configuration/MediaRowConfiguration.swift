//
//  MediaRowConfiguration.swift
//  
//
//  Created by Noah Kamara on 10.11.20.
//

import Foundation
import CoreGraphics
import SwiftUI

extension DesignConfiguration {
    public class MediaRow: ObservableObject {
        /// Default Configuration for Apple TV
        public static let atv: MediaRow = MediaRow(edgeInsets: EdgeInsets(top: 20, leading: 80, bottom: 50, trailing: 80), spacing: 48)
        
        
        /// Default Configuration for iOS
        public static let ios: MediaRow = MediaRow(edgeInsets: EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20), spacing: 20)
        
        /// Default Configuration for Mac
        public static let mac: MediaRow = MediaRow(edgeInsets: EdgeInsets(top: 0, leading: 80, bottom: 50, trailing: 0), spacing: 20)
        
        
        /// Media Row Padding
        public let edgeInsets: EdgeInsets
        
        /// Media Row Spacing
        public let spacing: CGFloat
        
        
        public init(edgeInsets: EdgeInsets, spacing: CGFloat) {
            self.edgeInsets = edgeInsets
            self.spacing = spacing
        }
    }
}
