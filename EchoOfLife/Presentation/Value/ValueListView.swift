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
    
    var viewModel: LifeItemViewModel
    
    @State var showCreate: Bool = false
    @State var valueToEdit: Value?
    
    @State private var showArchived: Bool = false
    
    var filteredValues: [Value] {
        if showArchived {
            return values.filter {
                $0.archivedAt != nil
            }
        } else {
            return values.filter {
                $0.archivedAt == nil
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            List(filteredValues, id: \.id) { value in
                NavigationLink {
                    ValueDetailView(
                        value: value,
                        lifeItemViewModel: viewModel,
                        onEdit: { valueToEdit = value },
                        onDelete: { delete(value) }
                    )
                } label: {
                    Text(value.name)
                }
                .swipeActions(edge: .trailing) {
                    Button {
                        delete(value)
                    } label: {
                        Image(systemName: "trash")
                    }
                    .tint(.red)
                }
                .swipeActions(edge: .leading) {
                    Button {
                        valueToEdit = value
                    } label: {
                        Image(systemName: "pencil")
                    }
                    .tint(.blue)
                }
            }
            .navigationTitle("Values")
            .toolbar {
                ToolbarItem {
                    Button {
                        showArchived.toggle()
                    } label: {
                        Image(systemName: showArchived ? "archivebox.circle.fill" : "archivebox.circle")
                    }
                }
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

//#Preview {
//    ValueListView()
//}
