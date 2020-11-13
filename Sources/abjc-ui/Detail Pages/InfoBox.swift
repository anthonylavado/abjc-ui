//
//  InfoBox.swift
//  
//
//  Created by Noah Kamara on 13.11.20.
//

import SwiftUI

struct InfoBox<Content: View>: View {
//
//    /// DesignConfiguration EnvironmentObject
//    @EnvironmentObject var designConfig: DesignConfiguration
    
    /// Label
    private let label: LocalizedStringKey
    
    /// Wrapped Content
    private let content: () -> Content
    
    public init(_ label: LocalizedStringKey, @ViewBuilder content: @escaping () -> Content) {
        self.label = label
        self.content = content
    }
    
    var body: some View {
        Button(action: {}) {
            VStack(alignment: .leading) {
                Text(label)
                    .bold()
                    .textCase(.uppercase)
                    .font(.headline)
                    
                content()
            }
        }.padding()
    }
}

struct InfoBox_Previews: PreviewProvider {
    static var previews: some View {
        InfoBox("hello") {
            Text("HELLO")
        }
    }
}

public struct InfoBoxInfo: View {
    private let title: LocalizedStringKey
    private let value: String
    
    public init(_ title: LocalizedStringKey, _ value: String) {
        self.title = title
        self.value = value
    }
    public var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.callout)
            Text(value)
                .font(.callout)
                .foregroundColor(.secondary)
        }
    }
}
