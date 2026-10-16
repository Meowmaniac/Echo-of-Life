//
//  LifeItemDetailView.swift
//  EchoOfLife
//
//  Created by Kateryna Pavlova on 29/09/2026.
//

import SwiftUI
import SwiftData

struct LifeItemDetailView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    let lifeItem: LifeItem
    let viewModel: LifeItemViewModel
    
    @State private var isShowingEdit = false
    @State private var isShowingDeleteConfirmation = false
    
    @Query(sort: \Reflection.createdAt, order: .reverse)
    private var reflections: [Reflection]
    @State private var reflectionToEdit: Reflection?
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                if let details = lifeItem.details {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Details")
                            .font(.headline)
                        
                        Text(details)
                            .font(.body)
                            .foregroundStyle(.secondary)
                    }
                }
                HStack(spacing: 8) {
                    Image(systemName: "diamond")
                    Text(lifeItem.type.rawValue.capitalized)
                }
                VStack(alignment: .leading, spacing: 12) {
                    Text("Information")
                        .font(.headline)
                    
                    HStack {
                        Label("Created", systemImage: "calendar")
                        
                        Spacer()
                        
                        Text(lifeItem.createdAt, format: .dateTime.day().month().year())
                            .foregroundStyle(.secondary)
                    }
                    if let occurredAt = lifeItem.occurredAt {
                        HStack {
                            Label("Occured", systemImage: "checkmark.circle")
                            
                            Spacer()
                            
                            Text(occurredAt, format: .dateTime.day().month().year())
                                .foregroundStyle(.secondary)
                        }
                    }
                    
                    if lifeItem.isAchievement {
                        Label("Achievement", systemImage: "star.fill")
                    }
                }
                VStack(alignment: .leading, spacing: 12) {
                    if !lifeItem.values.isEmpty {
                        Text("Values")
                            .font(.headline)
                        
                        ForEach(lifeItem.values, id: \.id) { value in
                            Text(value.name)
                                .padding(.horizontal, 10)
                                .padding(.vertical, 6)
                                .background(.secondary.opacity(0.15))
                                .clipShape(Capsule())
                        }
                    }
                }
                VStack(alignment: .leading, spacing: 12) {
                    Text("Reflections")
                        .font(.headline)
                    
                    let linkedReflections = reflections.filter {
                        $0.lifeItem?.id == lifeItem.id
                    }
                    
                    if linkedReflections.isEmpty {
                        Text("No reflections yet")
                            .foregroundStyle(.secondary)
                    } else {
                        ForEach(linkedReflections, id: \.id) { reflection in
                            NavigationLink {
                                ReflectionDetailView(
                                    reflection: reflection,
                                    onEdit: {
                                        reflectionToEdit = reflection
                                    },
                                    onDelete: {
                                        deleteReflection(reflection)
                                    }
                                )
                            } label: {
                                VStack(alignment: .leading, spacing: 6) {
                                    Text(
                                        reflection.createdAt,
                                        format: .dateTime.day().month().year()
                                    )
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                                    
                                    Text(reflection.text)
                                        .lineLimit(2)
                                        .foregroundStyle(.primary)
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(12)
                                .background(.secondary.opacity(0.1))
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                                .contentShape(RoundedRectangle(cornerRadius: 12))
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
            }
            .padding()
            .navigationTitle(lifeItem.title)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        isShowingEdit = true
                    } label: {
                        Image(systemName: "pencil")
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button(role: .destructive) {
                        isShowingDeleteConfirmation = true
                    } label: {
                        Image(systemName: "trash")
                    }
                }
            }
            .sheet(isPresented: $isShowingEdit) {
                LifeItemEditView(lifeItem: lifeItem)
            }
            .confirmationDialog(
                "Delete this life item?",
                isPresented: $isShowingDeleteConfirmation,
                titleVisibility: .visible
            ) {
                Button("Delete", role: .destructive) {
                    viewModel.deleteLifeItem(lifeItem)
                    
                    if viewModel.errorMessage == nil {
                        dismiss()
                    }
                }
            }
            .sheet(item: $reflectionToEdit) { reflection in
                ReflectionEditView(reflection: reflection)
            }
        }
    }
    
    private func deleteReflection(_ reflection: Reflection) {
        do {
            modelContext.delete(reflection)
            try modelContext.save()
        } catch {
            print("Failed to delete Reflection: \(error)")
        }
    }
}

//#Preview {
//    LifeItemDetailView(
//        lifeItem:
//            LifeItem(
//                id: UUID(),
//                type: .dream,
//                title: "Travel to Japan",
//                details: "Onsen, ramen, hentai, drift cars. Get IDP license in Ukraine. Visit Akihabara. Cherry blossom season. Trip to Kyoto. Sailor Moon museum. sumimasen, arigatou gozaimasu, doko desu ka, ikura desu ka",
//                createdAt: Calendar.current.date(
//                    from: DateComponents(
//                        year: 2026,
//                        month: 9,
//                        day: 29,
//                        hour: 14,
//                        minute: 30
//                    )
//                )!,
//                isAchievement: false
//            ),
//        onEdit: {},
//        onDelete: {}
//    )
//}
