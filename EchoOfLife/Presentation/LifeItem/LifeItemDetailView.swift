//
//  LifeItemDetailView.swift
//  EchoOfLife
//
//  Created by Kateryna Pavlova on 29/09/2026.
//

import SwiftUI

struct LifeItemDetailView: View {
    @Environment(\.dismiss) private var dismiss
    let lifeItem: LifeItem
    
    let onEdit: () -> Void
    let onDelete: () -> Void
    
    var body: some View {
        NavigationStack {
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
                }
                .padding()
                .navigationTitle(lifeItem.title)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button {
                            onEdit()
                        } label: {
                            Image(systemName: "pencil")
                        }
                    }
                    
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(role: .destructive) {
                            onDelete()
                            dismiss()
                        } label: {
                            Image(systemName: "trash")
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    LifeItemDetailView(
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
            ),
        onEdit: {},
        onDelete: {}
    )
}
