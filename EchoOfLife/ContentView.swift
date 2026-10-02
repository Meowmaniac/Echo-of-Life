//
//  ContentView.swift
//  EchoOfLife
//
//  Created by Kateryna Pavlova on 28/09/2026.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    let lifeItemRepository: LifeItemRepository

    var body: some View {
        TabView {
            LifeItemListView(repository: lifeItemRepository)
                .tabItem {
                    Label("Life", systemImage: "circle.grid.2x2")
                }
            ValueListView()
                .tabItem {
                    Label("Values", systemImage: "heart.fill")
                }
        }
    }
}

//#Preview {
//    ContentView()
//        .modelContainer()
//}
