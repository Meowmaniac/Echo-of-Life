//
//  ValueListView.swift
//  EchoOfLife
//
//  Created by Kateryna Pavlova on 02/10/2026.
//

import SwiftUI
import SwiftData

struct ValueListView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Value.createdAt, order: .reverse) var values: [Value]
    @State var showCreate: Bool = false
    @State var valueToEdit: Value?
    
    var body: some View {
        NavigationStack {
            List(values, id: \.id) { value in
                NavigationLink {
                    ValueDetailView(
                        value: value,
                        onEdit: { valueToEdit = value },
                        onDelete: { delete(value) }
                    )
                } label: {
                    Text(value.name)
                }
                .swipeActions(edge: .trailing) {
                    Button(role: .destructive) {
                        delete(value)
                    } label: {
                        Label("Delete", systemImage: "trash")
                    }
                }
                .swipeActions(edge: .leading) {
                    Button {
                        valueToEdit = value
                    } label: {
                        Label("Edit", systemImage: "pencil")
                    }
                }
            }
            .navigationTitle("Values")
            .toolbar {
                ToolbarItem {
                    Button {
                        showCreate = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showCreate) {
                ValueCreateView { newValue in
                    create(newValue)
                }
            }
            .sheet(item: $valueToEdit) { value in
                ValueEditView(value: value)
            }
        }
    }
    
    private func delete(_ value: Value) {
        modelContext.delete(value)

        do {
            try modelContext.save()
        } catch {
            print("Can't save the context: \(error.localizedDescription)")
        }
    }
    
    private func create(_ value: Value) {
        modelContext.insert(value)

        do {
            try modelContext.save()
        } catch {
            print("Can't save the context: \(error.localizedDescription)")
        }
    }
}

#Preview {
    ValueListView()
}
