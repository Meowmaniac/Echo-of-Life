//
//  ValueDetailView.swift
//  EchoOfLife
//
//  Created by Kateryna Pavlova on 03/10/2026.
//

import SwiftUI

struct ValueDetailView: View {
    @Environment(\.dismiss) private var dismiss
    var value: Value
    
    let onEdit: () -> Void
    let onDelete: () -> Void
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 16) {
                if let details = value.details {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Details")
                            .font(.headline)
                        
                        Text(details)
                            .font(.body)
                            .foregroundStyle(.secondary)
                    }
                }
                if let archivedAt = value.archivedAt {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Archived at")
                            .font(.headline)
                        
                        Text(archivedAt.formatted(date: .numeric, time: .shortened))
                            .font(.body)
                            .foregroundStyle(.secondary)
                    }
                }
                if !value.lifeItems.isEmpty {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Life Items")
                            .font(.headline)
                        ScrollView {
                            VStack(alignment: .leading, spacing: 8) {
                                ForEach(value.lifeItems, id: \.id) { item in
                                    HStack {
                                        Text(item.title)
                                        
                                        Spacer()
                                        
                                        if item.isAchievement {
                                            Image(systemName: "star.fill")
                                                .foregroundStyle(.yellow)
                                        }
                                    }
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 8)
                                    .background(.secondary.opacity(0.1))
                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                                }
                            }
                        }
                    }
                }
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .navigationTitle(value.name)
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

//#Preview {
//    ValueDetailView()
//}
