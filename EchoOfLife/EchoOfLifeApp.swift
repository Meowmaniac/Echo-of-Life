//
//  EchoOfLifeApp.swift
//  EchoOfLife
//
//  Created by Kateryna Pavlova on 28/09/2026.
//

import SwiftUI
import SwiftData

@main
struct EchoOfLifeApp: App {
    private let persistenceController: PersistenceController
    private let lifeItemRepository: LifeItemRepository

    init() {
        let persistenceController = PersistenceController()
        
        self.persistenceController = persistenceController
        self.lifeItemRepository = SwiftDataLifeItemRepository(
            modelContext: persistenceController.mainContext
        )
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView(lifeItemRepository: lifeItemRepository)
        }
        .modelContainer(persistenceController.container)
    }
}
