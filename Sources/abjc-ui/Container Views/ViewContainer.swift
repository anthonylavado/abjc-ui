//
//  ViewContainer.swift
//  
//
//  Created by Noah Kamara on 10.11.20.
//

import SwiftUI

struct ViewContainer<Content: View>: View {
    
    /// DesignConfiguration Environment
    @Environment(\.designConfig) var designConfig
    
    /// Wrapped Content
    private let content: () -> Content
    
    
    /// Reference to DesignConfiguration > MediaCard > Size
    private var embed: Bool { designConfig.navStyle == .tabs}
    
    public init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }
    
    var body: some View {
        if embed {
            NavigationView {
                content().edgesIgnoringSafeArea(.horizontal)
            }
        } else {
            content()
        }
    }
}

struct ViewContainer_Previews: PreviewProvider {
    static var previews: some View {
        ViewContainer() {
            Text("HELLO")
        }
    }
}
