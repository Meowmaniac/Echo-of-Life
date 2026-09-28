//
//  Reflection.swift
//  EchoOfLife
//
//  Created by Kateryna Pavlova on 28/09/2026.
//

import Foundation
import SwiftData

@Model
final class Reflection {
    var id: UUID
    
    var text: String
    
    var createdAt: Date
    
    var period: ReflectionPeriod?
    var periodStart: Date?
    
    var lifeItem: LifeItem?
    
    init(
        id: UUID = UUID(),
        text: String,
        createdAt: Date = .now,
        period: ReflectionPeriod? = nil,
        periodStart: Date? = nil,
        lifeItem: LifeItem? = nil
    ) {
        self.id = id
        self.text = text
        self.createdAt = createdAt
        self.period = period
        self.periodStart = periodStart
        self.lifeItem = lifeItem
    }
}

enum ReflectionPeriod: String, Codable {
    case day
    case month
    case year
    // later add custom period
}
