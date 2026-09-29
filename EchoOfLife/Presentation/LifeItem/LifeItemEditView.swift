//
//  LifeItemEditView.swift
//  EchoOfLife
//
//  Created by Kateryna Pavlova on 29/09/2026.
//

import SwiftUI
import SwiftData

struct LifeItemEditView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    
    @Bindable var lifeItem: LifeItem
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Life Item") {
                    TextField("Title", text: $lifeItem.title)
                    
                    TextField(
                        "Details",
                        text: Binding(
                            get: { lifeItem.details ?? "" },
                            set: { lifeItem.details = $0.isEmpty ? nil : $0 }
                        ),
                        axis: .vertical
                    )
                    
                    Picker("Type", selection: $lifeItem.type) {
                        ForEach(
                            [
                                LifeItemType.desire,
                                .dream,
                                .experience,
                                .challenge
                            ],
                            id: \.self
                        ) { type in
                            Text(type.rawValue.capitalized)
                                .tag(type)
                        }
                    }
                    
                    Toggle(
                        "Achievement",
                        isOn: $lifeItem.isAchievement
                    )
                }
            }
            .navigationTitle("Edit Life Item")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") {
                        do {
                            try modelContext.save()
                            dismiss()
                        } catch {
                            print("Failed to save LifeItem: \(error)") // change later
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    LifeItemEditView(
        lifeItem:
            LifeItem(
                id: UUID(),
                type: .dream,
                title: "Travel to Japan",
                details: "Onsen, ramen, hentai, drift cars. Get IDP license in Ukraine. Visit Akihabara. Cherry blossom season. Trip to Kyoto. Sailor Moon museum. sumimasen, arigatou gozaimasu, doko desu ka, ikura desu ka",
                createdAt: Calendar.current.date(
                    from: DateComponents(
                        year: 2026,
                        month: 9,
                        day: 29,
                        hour: 14,
                        minute: 30
                    )
                )!,
                isAchievement: false
            )
    )
}
