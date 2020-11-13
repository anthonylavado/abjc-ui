//
//  MoviePage.swift
//  
//
//  Created by Noah Kamara on 10.11.20.
//

import SwiftUI
import URLImage

import abjc_core
import abjc_api


/// ItemDetailPage Movie
struct MoviePage: View {
    
    /// SessionStore EnvironmentObject
    @EnvironmentObject var session: SessionStore
    
    /// PlayerStore EnvironmentObject
    @EnvironmentObject var playerStore: PlayerStore
    
    /// DesignConfiguration EnvironmentObject
    @EnvironmentObject var designConfig: DesignConfiguration

    
    /// Media Item (Series)
    private let item: API.Models.Item
    
    
    /// Initializer
    /// - Parameter item: Series
    public init(_ item: API.Models.Item) {
        self.item = item
    }
    
    
    /// Movie Item
    @State var detailItem: API.Models.Movie?
    
    /// Images for Item
    @State var images: [API.Models.Image] = []
    
    /// Similar Items (Recommended)
    @State var similarItems: [API.Models.Item] = []
    
    
    
    /// ViewBuilder body
    var body: some View {
        GeometryReader { geo in
            ScrollView(.vertical, showsIndicators: true) {
                headerView
                    .frame(width: geo.size.width, height: geo.size.height)
//                    .background(backdrop.edgesIgnoringSafeArea(.all))
                infoView
                peopleView
                recommendedView
            }
        }
        .onAppear(perform: load)
    }
    
    /// Header
    var headerView: some View {
        VStack(alignment: .leading) {
            Spacer()
            HStack(alignment: .top) {
                VStack(alignment: .leading) {
                    Text(item.name)
                        .bold()
                        .font(.title2)
                    Text(item.year != nil ? "\(String(item.year!))" : "")
                        .foregroundColor(.secondary)
                }
                Spacer()
                Button(action: {
                    if let item = self.detailItem {
                        playerStore.play(item)
                    }
                }) {
                    Text("buttons.play")
                        .bold()
                        .textCase(.uppercase)
                        .frame(width: 300)
                }.foregroundColor(.accentColor)
                .padding(.trailing)
            }.disabled(detailItem == nil)
            if item.overview != nil {
                Divider()
                HStack() {
                    Text(self.item.overview ?? "")
                }
            }
        }
        .padding(.horizontal, 80)
        .padding(.bottom, 80)
    }
    
    
    /// Image Backdrop
    var backdrop: some View {
        Image.fromBlurHash(item.blurHash(for: .backdrop) ?? item.blurHash(for: .primary) ?? "", size: CGSize(width: 32, height: 32))
            .renderingMode(.original)
            .resizable()
    }
    
    /// Info View
    var infoView: some View {
        VStack(alignment: .leading, spacing: 0) {
            Divider()
            ScrollView(.horizontal, showsIndicators: false) {
                HStack() {
                    InfoBox("infobox.info") {
                        InfoBoxInfo("infobox.release", detailItem?.year != nil ? String(detailItem!.year!) : "ERR")
                        Spacer()
                        InfoBoxInfo("infobox.duration", String(item.runTime))
                        Spacer()
                        InfoBoxInfo("infobox.critics", detailItem?.criticRating != nil ? String(detailItem!.criticRating!) : "")
                    }
                }
            }.edgesIgnoringSafeArea(.horizontal)
        }.edgesIgnoringSafeArea(.horizontal)
    }
    
    
    /// People Row
    var peopleView: some View {
        Group {
            EmptyView()
            if self.detailItem?.people?.count != 0 {
                Divider().padding(.horizontal, 80)
                PeopleRow("", self.detailItem?.people ?? [])
            } else {
                EmptyView()
            }
        }.edgesIgnoringSafeArea(.horizontal)
    }
    
    
    /// Recommended View
    var recommendedView: some View {
        Group {
            if self.similarItems.count != 0 {
                Divider().padding(.horizontal, 80)
                MediaRow("itemdetail.recommended.label", self.similarItems, session.api.getImageURL)
            } else {
                EmptyView()
            }
        }
    }

    /// Loads Content From API
    func load() {
        print("MOVIE LOADING")
        // Fetch Item Detail
        session.api.getMovie(item.id) { result in
            switch result {
                case .success(let item): self.detailItem = item
                case .failure(let error):
                    print(error)
                    DispatchQueue.main.async {
                        session.alert = AlertError("alerts.apierror", error.localizedDescription)
                    }
            }
        }
        
        // Fetch Images for Item
        session.api.getImages(for: item.id) { result in
            switch result {
                case .success(let images): self.images = images
                case .failure(let error):
                    print(error)
                    DispatchQueue.main.async {
                        session.alert = AlertError("alerts.apierror", error.localizedDescription)
                    }
            }
        }
        
        // Fetch Similar Items
        session.api.getSimilar(for: item.id) { result in
            switch result {
                case .success(let items): self.similarItems = items
                case .failure(let error):
                    print(error)
                    DispatchQueue.main.async {
                        session.alert = AlertError("alerts.apierror", error.localizedDescription)
                    }
            }
        }
    }
}
