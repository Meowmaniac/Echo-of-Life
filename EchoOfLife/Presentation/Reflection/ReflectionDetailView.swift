//
//  ReflectionDetailView.swift
//  EchoOfLife
//
//  Created by Kateryna Pavlova on 16/10/2026.
//

import SwiftUI
import SwiftData

struct ReflectionDetailView: View {
    @Environment(\.dismiss) private var dismiss

    let reflection: Reflection
    let onEdit: () -> Void
    let onDelete: () -> Void

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Reflection")
                            .font(.headline)

                        Text(reflection.text)
                            .font(.body)
                    }

                    VStack(alignment: .leading, spacing: 12) {
                        Text("Information")
                            .font(.headline)

                        HStack {
                            Label("Created", systemImage: "calendar")
                            Spacer()
                            Text(
                                reflection.createdAt,
                                format: .dateTime.day().month().year()
                            )
                            .foregroundStyle(.secondary)
                        }

                        if let periodStart = reflection.periodStart {
                            HStack {
                                Label("Period start", systemImage: "calendar")
                                Spacer()
                                Text(
                                    periodStart,
                                    format: .dateTime.day().month().year()
                                )
                                .foregroundStyle(.secondary)
                            }
                        }

                        if let period = reflection.period {
                            HStack {
                                Label("Period", systemImage: "clock")
                                Spacer()
                                Text(period.rawValue.capitalized)
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }

                    if let lifeItem = reflection.lifeItem {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Life Item")
                                .font(.headline)

                            HStack {
                                Image(systemName: "diamond")
                                Text(lifeItem.title)
                                Spacer()
                                if lifeItem.isAchievement {
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
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .navigationTitle("Reflection")
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
//    ReflectionDetailView()
//}
