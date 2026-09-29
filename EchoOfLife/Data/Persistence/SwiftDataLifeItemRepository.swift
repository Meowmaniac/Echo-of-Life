//
//  SwiftDataLifeItemRepository.swift
//  EchoOfLife
//
//  Created by Kateryna Pavlova on 28/09/2026.
//

import Foundation
import SwiftData

final class SwiftDataLifeItemRepository: LifeItemRepository {
    private let modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    func fetchAll() throws -> [LifeItem] {
        let descriptor = FetchDescriptor<LifeItem>(
            sortBy: [SortDescriptor(\.createdAt, order: .reverse)]
        )
        
        return try modelContext.fetch(descriptor)
    }
    
    func save(_ item: LifeItem) throws {
        modelContext.insert(item)
        try modelContext.save()
    }
    
    func delete(_ item: LifeItem) throws {
        modelContext.delete(item)
        try modelContext.save()
    }
}
