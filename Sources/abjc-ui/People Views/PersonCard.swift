//
//  PersonCard.swift
//  
//
//  Created by Noah Kamara on 10.11.20.
//

import SwiftUI
import URLImage

import abjc_core
import abjc_api


/// PersonCard
public struct PersonCard: View {
    
    /// SessionStore EnvironmentObject
    @EnvironmentObject var session: SessionStore
    
    /// DesignConfiguration Environment
    @Environment(\.designConfig) var designConfig
    
    /// Reference to DesignConfiguration > PersonCard > Width
    private var size: CGFloat { designConfig.personCard.size }
    
    
    /// Person Item
    var person: API.Models.Person
    
    
    /// Initializer
    /// - Parameter person: Person Item
    public init(_ person: API.Models.Person) {
        self.person = person
    }
    
    
    /// ViewBuilder body
    public var body: some View {
        VStack {
            imageView
            .clipShape(Circle())
            .clipped()
            .frame(width: size, height: size)
            .padding([.horizontal, .top], 10)
            
            VStack {
                Text(person.name)
                Text(person.role ?? " ")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }.padding([.horizontal, .bottom], 10)
        }.frame(width: size)
    }
    
    
    /// Image View 
    var imageView: some View {
        URLImage(
            url: session.api.getImageURL(for: person.id, .primary),
            empty: { blur },
            inProgress: { _ in blur },
            failure:  { _,_ in blur }
        ) { image in
            image
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(alignment: .top)
        }
    }
    
    /// Placeholder for missing URLImage
    private var blur: some View {
        Blur().clipShape(Circle())
    }
}
