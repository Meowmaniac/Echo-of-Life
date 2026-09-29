//
//  PreviewData.swift
//  EchoOfLife
//
//  Created by Kateryna Pavlova on 29/09/2026.
//

import Foundation
import SwiftData

@MainActor
enum PreviewData {
    static let container: ModelContainer = {
        let schema = Schema([
            LifeItem.self,
            Value.self,
            Reflection.self
        ])

        let configuration = ModelConfiguration(
            schema: schema,
            isStoredInMemoryOnly: true
        )

        do {
            let container = try ModelContainer(
                for: schema,
                configurations: [configuration]
            )

            let context = container.mainContext

            context.insert(
                LifeItem(
                    type: .dream,
                    title: "Visit Japan"
                )
            )

            context.insert(
                LifeItem(
                    type: .experience,
                    title: "Started learning Japanese",
                    isAchievement: true
                )
            )

            try context.save()

            return container
        } catch {
            fatalError("Failed to create preview container: \(error)")
        }
    }()
}
