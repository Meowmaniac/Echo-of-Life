//
//  ReflectionListView.swift
//  EchoOfLife
//
//  Created by Kateryna Pavlova on 15/10/2026.
//

import SwiftUI
import SwiftData

struct ReflectionListView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Reflection.createdAt, order: .reverse) var reflections: [Reflection]
    @State private var showCreate: Bool = false
    @State private var reflectionToEdit: Reflection?
    
    private var sortedReflections: [Reflection] {
        reflections.sorted { $0.sortDate > $1.sortDate }
    }
    
    var body: some View {
        NavigationStack {
            List(sortedReflections, id: \.id) { reflection in
                NavigationLink {
                    ReflectionDetailView(
                        reflection: reflection,
                        onEdit: { reflectionToEdit = reflection },
                        onDelete: { delete(reflection) }
                    )
                } label : {
                    VStack(alignment: .leading, spacing: 8) {
                        Text((reflection.periodStart ?? reflection.createdAt).formatted(date: .numeric, time: .omitted))
                            .font(.body)
                            .foregroundStyle(.secondary)
                        Text(reflection.text)
                            .lineLimit(1)
                            .truncationMode(.tail)
                    }
                }
                .swipeActions(edge: .trailing) {
                    Button {
                        delete(reflection)
                    } label: {
                        Image(systemName: "trash")
                    }
                    .tint(.red)
                }
                .swipeActions(edge: .leading) {
                    Button {
                        reflectionToEdit = reflection
                    } label: {
                        Image(systemName: "pencil")
                    }
                    .tint(.blue)
                }
                    
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showCreate = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showCreate) {
                ReflectionCreateView { newReflection in
                    create(newReflection)
                }
            }
            .sheet(item: $reflectionToEdit) { reflection in
                ReflectionEditView(reflection: reflection)
            }
        }
    }
    
    private func create(_ reflection: Reflection) {
        modelContext.insert(reflection)

        do {
            try modelContext.save()
        } catch {
            print("Can't save the context: \(error.localizedDescription)")
        }
    }
    
    private func delete(_ reflection: Reflection) {
        modelContext.delete(reflection)

        do {
            try modelContext.save()
        } catch {
            print("Can't save the context: \(error.localizedDescription)")
        }
    }
}

//#Preview {
//    ReflectionListView()
//}
