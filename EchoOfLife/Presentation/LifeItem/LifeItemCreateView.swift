//
//  CreateView.swift
//  EchoOfLife
//
//  Created by Kateryna Pavlova on 29/09/2026.
//

import SwiftUI
import SwiftData

struct LifeItemCreateView: View {
    @Environment(\.dismiss) private var dismiss
    
    @Query(sort: \Value.name) private var values: [Value]

    @State private var title = ""
    @State private var details = ""
    @State private var type: LifeItemType = .experience
    @State private var isAchievement = false
    @State private var isOccured = false
    @State private var dateOccurred = Date()
    @State private var selectedValues: [Value] = []

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
                Section("Values") {
                    Menu {
                        ForEach(values, id: \.id) { value in
                            Button {
                                toggleValue(value)
                            } label: {
                                HStack {
                                    Text(value.name)

                                    if selectedValues.contains(where: { $0.id == value.id }) {
                                        Image(systemName: "checkmark")
                                    }
                                }
                            }
                        }
                    } label: {
                        HStack {
                            Text("Select Values")
                            Spacer()
                            Image(systemName: "chevron.up.chevron.down")
                                .foregroundStyle(.secondary)
                        }
                    }
                    
                    if !selectedValues.isEmpty {
                        LazyVGrid(
                            columns: [
                                GridItem(.adaptive(minimum: 80), spacing: 8)
                            ],
                            alignment: .leading,
                            spacing: 8
                        ) {
                            ForEach(selectedValues, id: \.id) { value in
                                Text(value.name)
                                    .padding(.horizontal, 10)
                                    .padding(.vertical, 6)
                                    .background(.secondary.opacity(0.15))
                                    .clipShape(Capsule())
                            }
                        }
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
                            isAchievement: isAchievement,
                            values: selectedValues
                        )

                        onSave(item)
                        dismiss()
                    }
                    .disabled(title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
            }
        }
    }
    
    private func toggleValue(_ value: Value) {
        if let index = selectedValues.firstIndex(where: { $0.id == value.id }) {
            selectedValues.remove(at: index)
        } else {
            selectedValues.append(value)
        }
    }
}
