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
    @Query(sort: \Value.name) private var values: [Value]
    
    @Bindable var lifeItem: LifeItem
    @State private var isOccured = false
    @State private var dateOccurred = Date()
    
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
                    Toggle("Occured", isOn: $isOccured)
                    if isOccured {
                        DatePicker(
                            "Date",
                            selection: Binding(
                                get: { lifeItem.occurredAt ?? Date() },
                                set: { lifeItem.occurredAt = $0 }
                            ),
                            displayedComponents: .date
                        )
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

                                    if lifeItem.values.contains(where: { $0.id == value.id }) {
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
                    
                    if !lifeItem.values.isEmpty {
                        LazyVGrid(
                            columns: [
                                GridItem(.adaptive(minimum: 80), spacing: 8)
                            ],
                            alignment: .leading,
                            spacing: 8
                        ) {
                            ForEach(lifeItem.values, id: \.id) { value in
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
    
    private func toggleValue(_ value: Value) {
        if let index = lifeItem.values.firstIndex(where: { $0.id == value.id }) {
            lifeItem.values.remove(at: index)
        } else {
            lifeItem.values.append(value)
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
