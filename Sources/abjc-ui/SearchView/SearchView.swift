//
//  SearchView.swift
//  
//
//  Created by Noah Kamara on 11.11.20.
//

import SwiftUI

import abjc_core
import abjc_api

public struct SearchView: View {
    
    /// SessionStore EnvironmentObject
    @EnvironmentObject var session: SessionStore
    
    /// DesignConfiguration Environment
    @Environment(\.designConfig) var designConfig
    
    
    /// Query String
    @State var query: String = ""
    
    
    /// Search Result Items
    @State var items: [API.Models.Item] = []
    
    /// Search Result People
    @State var people: [API.Models.Person] = []
    
    public var body: some View {
        ViewContainer() {
            ScrollView([.vertical]) {
                TextField("search.label", text: $query, onCommit: search)
                    .padding(.horizontal, 80)
                
                LazyVStack(alignment: .leading) {
                    if items.count != 0 {
                        MediaRow("", items, session.api.getImageURL, session.preferences)
                    }
                    
                    if people.count != 0 {
                        Divider()
                        PeopleRow("search.people.label", people)
                    }
                }
            }.edgesIgnoringSafeArea(.horizontal)
        }
    }
    
    
    /// search
    func search() {
        session.api.searchItems(query) { result in
            switch result {
                case .success(let items): self.items = items
                case .failure(let error): print(error)
            }
        }
        session.api.searchPeople(query) { result in
            switch result {
                case .success(let items): self.people = items
                case .failure(let error): print(error)
            }
        }
    }
}
