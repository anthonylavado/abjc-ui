//
//  ViewContainer.swift
//  
//
//  Created by Noah Kamara on 10.11.20.
//

import SwiftUI

struct ViewContainer<Content: View>: View {
    private let isInnerNav: Bool
    let content: () -> Content
    
    public init(_ isInnerNav: Bool = true, @ViewBuilder content: @escaping () -> Content) {
        self.isInnerNav = isInnerNav
        self.content = content
    }
    
    var body: some View {
        if !isInnerNav {
            NavigationView {
                content()
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
