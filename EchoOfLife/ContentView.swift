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
        LifeItemListView(repository: lifeItemRepository)
    }
}

//#Preview {
//    ContentView()
//        .modelContainer()
//}
