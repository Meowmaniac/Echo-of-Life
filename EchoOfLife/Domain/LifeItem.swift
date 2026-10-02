//
//  LifeItem.swift
//  EchoOfLife
//
//  Created by Kateryna Pavlova on 28/09/2026.
//

import Foundation
import SwiftData
import SwiftUI

@Model
final class LifeItem {
    var id: UUID
    var type: LifeItemType
    var title: String
    var details: String?
    
    var createdAt: Date
    var occurredAt: Date?
    
    var isAchievement: Bool
    
    var parentItem: LifeItem?
    @Relationship(inverse: \LifeItem.parentItem)
    var childItems: [LifeItem]
    
    @Relationship
    var values: [Value]
    
    init(
        id: UUID = UUID(),
        type: LifeItemType,
        title: String,
        details: String? = nil,
        createdAt: Date = .now,
        occurredAt: Date? = nil,
        isAchievement: Bool = false,
        values: [Value] = [],
        parentItem: LifeItem? = nil,
        childItems: [LifeItem] = []
    ) {
        self.id = id
        self.type = type
        self.title = title
        self.details = details
        self.createdAt = createdAt
        self.occurredAt = occurredAt
        self.isAchievement = isAchievement
        self.values = values
        self.parentItem = parentItem
        self.childItems = childItems
    }
}

enum LifeItemType: String, Codable, CaseIterable {
    case desire
    case dream
    case experience
    case challenge
}

extension LifeItemType {
    var localizedTitle: LocalizedStringKey {
        switch self {
        case .desire:
            "Desire"
        case .dream:
            "Dream"
        case .experience:
            "Experience"
        case .challenge:
            "Challenge"
        }
    }
}
