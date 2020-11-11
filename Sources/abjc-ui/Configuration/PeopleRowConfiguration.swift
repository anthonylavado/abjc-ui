//
//  File.swift
//  
//
//  Created by Noah Kamara on 10.11.20.
//

import Foundation
import SwiftUI

extension DesignConfiguration {
    public class PeopleRow: ObservableObject {
        /// Default Configuration for Apple TV
        public static let atv: PeopleRow = PeopleRow(edgeInsets: EdgeInsets(top: 0, leading: 80, bottom: 50, trailing: 0), spacing: 48)
        
        
        /// Default Configuration for iPad
        public static let pad: PeopleRow = PeopleRow(edgeInsets: EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 0), spacing: 20)
        
        /// Default Configuration for iPhone
        public static let fon: PeopleRow = PeopleRow(edgeInsets: EdgeInsets(top: 0, leading: 80, bottom: 50, trailing: 0), spacing: 20)
        
        
        /// People Row Padding
        public let edgeInsets: EdgeInsets
        
        /// People Row Spacing
        public let spacing: CGFloat
        
        
        public init(edgeInsets: EdgeInsets, spacing: CGFloat) {
            self.edgeInsets = edgeInsets
            self.spacing = spacing
        }
    }
}
