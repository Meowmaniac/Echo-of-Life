//
//  Value.swift
//  EchoOfLife
//
//  Created by Kateryna Pavlova on 28/09/2026.
//

import Foundation
import SwiftData

@Model
final class Value {
    var id: UUID
    var name: String
    var details: String?
    
    var createdAt: Date
    var archivedAt: Date?
    
    @Relationship(inverse: \LifeItem.values)
    var lifeItems: [LifeItem]
    
    init(
        id: UUID = UUID(),
        name: String,
        details: String? = nil,
        createdAt: Date = .now,
        archivedAt: Date? = nil,
        lifeItems: [LifeItem] = []
    ) {
        self.id = id
        self.name = name
        self.details = details
        self.createdAt = createdAt
        self.archivedAt = archivedAt
        self.lifeItems = lifeItems
    }
}
