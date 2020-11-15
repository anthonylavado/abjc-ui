//
//  PeopleRow.swift
//  
//
//  Created by Noah Kamara on 10.11.20.
//

import SwiftUI
import URLImage

import abjc_core
import abjc_api


public struct PeopleRow: View {
    
    /// SessionStore EnvironmentObject
    @EnvironmentObject var session: SessionStore
    
    /// DesignConfiguration Environment
    @Environment(\.designConfig) var designConfig
    
    /// Reference to DesignConfiguration > PeopleRow > Padding
    private var edgeInsets: EdgeInsets { designConfig.peopleRow.edgeInsets }
    
    /// Reference to DesignConfiguration > PeopleRow > Spacing
    private var spacing: CGFloat { designConfig.peopleRow.spacing }
    
    
    /// Row Label
    private var label: LocalizedStringKey
    
    /// People Array
    var people: [API.Models.Person]
    
    
    /// Initializer
    /// - Parameters:
    ///   - label: Row Label
    ///   - people: Row People
    public init(_ label: String, _ people: [API.Models.Person]) {
        self.label = LocalizedStringKey(label)
        self.people = people
    }
    
    /// Initializer
    /// - Parameters:
    ///   - label: Localized Row Label
    ///   - people: Row People
    public init(_ label: LocalizedStringKey, _ people: [API.Models.Person]) {
        self.label = label
        self.people = people
    }
    
    
    
    /// ViewBuilder body
    public var body: some View {
        VStack(alignment: .leading) {
            Text(label)
                .font(.title3)
                .padding(.horizontal, edgeInsets.leading)
            ScrollView(.horizontal) {
                LazyHStack(spacing: spacing) {
                    ForEach(people, id:\.id) { person in
                        Button(action: {}) {
                            PersonCard(person)
                        }
                    }
                }
                .padding(edgeInsets)
            }
        }
    }
}

struct PeopleRow_Previews: PreviewProvider {
    static var previews: some View {
        PeopleRow("People Row", [])
    }
}
