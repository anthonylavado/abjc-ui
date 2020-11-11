//
//  ServerCard.swift
//  
//
//  Created by Noah Kamara on 11.11.20.
//

import SwiftUI

import abjc_core
import abjc_api

extension AuthView.ServerSelectionView {
    public struct ServerCard: View {
        
        /// Title
        private let title: LocalizedStringKey
        
        /// Subtitle
        private let subtitle: LocalizedStringKey
        
        
        /// Initializer
        /// - Parameters:
        ///   - title: Title
        ///   - subtitle: Subtitle
        public init(_ title: String, _ subtitle: String) {
            self.title = LocalizedStringKey(title)
            self.subtitle = LocalizedStringKey(subtitle)
        }
        
        public var body: some View {
            VStack {
                Text(title)
                    .bold()
                    .font(.headline)
                    .textCase(.uppercase)
                Text(subtitle)
                    .font(.system(.callout, design: .monospaced))
                    .foregroundColor(.secondary)
            }
        }
    }
}
