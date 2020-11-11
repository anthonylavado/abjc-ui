//
//  SwiftUIView.swift
//  
//
//  Created by Noah Kamara on 10.11.20.
//

import SwiftUI
import AVKit

struct PlayerOverlay: View {
    @Binding var player: AVPlayer?
    
    public init(_ player: Binding<AVPlayer?>) {
        self._player = player
    }
    var body: some View {
        EmptyView()
    }
}
