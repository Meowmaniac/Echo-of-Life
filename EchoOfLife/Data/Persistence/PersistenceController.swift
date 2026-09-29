//
//  ModelContainerFactory.swift
//  EchoOfLife
//
//  Created by Kateryna Pavlova on 28/09/2026.
//

import Foundation
import SwiftData

final class PersistenceController {
    let container: ModelContainer
    
    var mainContext: ModelContext {
        container.mainContext
    }

    init() {
        do {
            container = try ModelContainer(
                for: LifeItem.self,
                Value.self,
                Reflection.self
            )
        } catch {
            fatalError("Failed to create ModelContainer: \(error)")
        }
    }
}
