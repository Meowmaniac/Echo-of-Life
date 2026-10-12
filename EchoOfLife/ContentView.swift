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
    @State private var lifeItemViewModel: LifeItemViewModel

    init(lifeItemRepository: LifeItemRepository) {
        self.lifeItemRepository = lifeItemRepository
        _lifeItemViewModel = State(
            initialValue: LifeItemViewModel(repository: lifeItemRepository)
        )
    }
    
    var body: some View {
        TabView {
            LifeItemListView(viewModel: lifeItemViewModel)
                .tabItem {
                    Label("Life", systemImage: "circle.grid.2x2")
                }
            ValueListView(viewModel: lifeItemViewModel)
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
