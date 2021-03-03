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
    
    /// Library Items
    @State var libItems: [API.Models.Item] = []
    
    /// Starting letters
    private var letters: [Character] {
        return libItems.compactMap({ ($0.name.uppercased().first ?? "Z") }).uniques
    }
    
    /// Search Result Items
    @State var searchItems: [API.Models.Item] = []
    
    /// Search Result People
    @State var people: [API.Models.Person] = []
    
    public var body: some View {
        ViewContainer() {
            ScrollView([.vertical]) {
                TextField("search.label", text: $query, onCommit: search)
                    .padding(.horizontal, 80)
                
                if query == "" {
                    libraryView
                } else {
                    searchResults
                }
            }.edgesIgnoringSafeArea(.horizontal)
        }.onAppear(perform: load)
    }
    
    /// Library View
    private var libraryView: some View {
        LazyVStack(alignment: .leading) {
            if libItems.count > 0 {
                ForEach(letters, id:\.self) { letter in
                    MediaRow(String(letter),
                             libItems.filter({ ($0.name.first ?? "Z") == letter }),
                             session.api.getImageURL, session.preferences)
                    Divider()
                }
            } else {
                EmptyView()
            }
        }
    }
    
    
    /// Search Results
    private var searchResults: some View {
        LazyVStack(alignment: .leading) {
            if searchItems.count != 0 {
                MediaRow("", searchItems, session.api.getImageURL, session.preferences)
            }
            
            if people.count != 0 {
                Divider()
                PeopleRow("search.people.label", people)
            }
        }
    }
    
    /// search
    func search() {
        if query == "" {
            self.searchItems = []
            self.people = []
            return
        }
        session.api.searchItems(query) { result in
            switch result {
                case .success(let items): self.searchItems = items
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
    
    /// Load default view
    func load() {
        self.libItems = session.items
        if session.hasUser {
            session.api.getItems() { result in
                switch result {
                    case .success(let items):
                        if self.libItems != items {
                            self.libItems = items
                            session.updateItems(items)
                        }
                    case .failure(let error):
                        if session.preferences.isDebugEnabled {
                            DispatchQueue.main.async {
                                session.alert = AlertError("alerts.apierror", error)
                            }
                        } else {
                            DispatchQueue.main.async {
                                session.alert = AlertError("alerts.apierror", error.localizedDescription)
                            }
                        }
                }
            }
        }
    }
}
