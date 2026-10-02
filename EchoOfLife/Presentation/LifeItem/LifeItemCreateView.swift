//
//  CreateView.swift
//  EchoOfLife
//
//  Created by Kateryna Pavlova on 29/09/2026.
//

import SwiftUI

struct LifeItemCreateView: View {
    @Environment(\.dismiss) private var dismiss

    @State private var title = ""
    @State private var details = ""
    @State private var type: LifeItemType = .experience
    @State private var isAchievement = false
    @State private var isOccured = false
    @State private var dateOccurred = Date()

    let onSave: (LifeItem) -> Void

    var body: some View {
        NavigationStack {
            Form {
                Section("Life Item") {
                    TextField("Title", text: $title)

                    TextField(
                        "Details",
                        text: $details,
                        axis: .vertical
                    )

                    Picker("Type", selection: $type) {
                        ForEach(
                            [LifeItemType.desire,
                             .dream,
                             .experience,
                             .challenge],
                            id: \.self
                        ) { type in
                            Text(type.rawValue.capitalized)
                                .tag(type)
                        }
                    }

                    Toggle("Achievement", isOn: $isAchievement)
                    Toggle("Occured", isOn: $isOccured)
                    if isOccured {
                        DatePicker("Date", selection: $dateOccurred, displayedComponents: .date)
                    }
                }
            }
            .navigationTitle("New Life Item")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }

                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        let item = LifeItem(
                            type: type,
                            title: title,
                            details: details.isEmpty ? nil : details,
                            occurredAt: isOccured ? dateOccurred : nil,
                            isAchievement: isAchievement
                        )

                        onSave(item)
                        dismiss()
                    }
                    .disabled(title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
            }
        }
    }
}
