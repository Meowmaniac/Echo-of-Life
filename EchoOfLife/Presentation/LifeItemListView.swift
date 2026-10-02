//
//  LifeItemListView].swift
//  EchoOfLife
//
//  Created by Kateryna Pavlova on 29/09/2026.
//

import SwiftUI
import SwiftData

struct LifeItemListView: View {
    @Query(sort: \LifeItem.createdAt, order: .reverse) var lifeItems: [LifeItem]
    @State var viewModel: LifeItemListViewModel
    @State var showCreate = false
    @State private var itemToEdit: LifeItem?
    @State private var selectedType: LifeItemType?
    
    // okay for small dataset
    var filteredLifeItems: [LifeItem] {
        guard let selectedType else {
            return lifeItems
        }

        return lifeItems.filter {
            $0.type == selectedType
        }
    }
    
    init(repository: LifeItemRepository) {
        _viewModel = State(
            initialValue: LifeItemListViewModel(repository: repository)
        )
    }
    
    var body: some View {
        NavigationStack {
            List(filteredLifeItems, id: \.id) { lifeItem in
                HStack {
                    NavigationLink {
                        LifeItemDetailView(
                            lifeItem: lifeItem,
                            onEdit: { itemToEdit = lifeItem },
                            onDelete: { viewModel.deleteLifeItem(lifeItem) }
                        )
                    } label: {
                        HStack {
                            VStack(alignment: .leading) {
                                Text(lifeItem.title)
                                Text(lifeItem.type.rawValue)
                                    .foregroundStyle(.secondary)
                                Text(lifeItem.occurredAt == nil ? lifeItem.createdAt : lifeItem.occurredAt!, format: .dateTime.day().month().year())
                                    .foregroundStyle(.secondary)
                            }
                            Spacer()
                            Button {
                                lifeItem.isAchievement.toggle()
                            } label: {
                                Image(
                                    systemName: lifeItem.isAchievement
                                        ? "star.fill"
                                        : "star"
                                )
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
                .swipeActions(edge: .trailing) {
                    deleteAction(item: lifeItem)
                }
                .swipeActions(edge: .leading) {
                    editAction(item: lifeItem)
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                            showCreate = true
                    }) {
                        Image(systemName: "plus")
                    }
                }
                ToolbarItem {
                    Menu {
                        Button("All") {
                            selectedType = nil
                        }

                        ForEach(LifeItemType.allCases, id: \.self) { type in
                            Button {
                                selectedType = type
                            } label: {
                                HStack {
                                    Text(type.localizedTitle)

                                    if selectedType == type {
                                        Image(systemName: "checkmark")
                                    }
                                }
                            }
                        }
                    } label: {
                        Image(systemName: selectedType == nil
                            ? "line.3.horizontal.decrease"
                            : "line.3.horizontal.decrease.circle.fill"
                        )
                    }
                }
            }
        }
        .sheet(isPresented: $showCreate) {
            LifeItemCreateView { item in
                viewModel.saveLifeItem(item)
            }
        }
        .sheet(item: $itemToEdit) { item in
            LifeItemEditView(lifeItem: item)
        }
    }
    
    private func deleteAction(item: LifeItem) -> some View {
        Button(action: {
            viewModel.deleteLifeItem(item)
        }) {
            Image(systemName: "trash")
        }
        .tint(.red)
    }
    
    private func editAction(item: LifeItem) -> some View {
        Button(action: {
            itemToEdit = item
        }) {
            Image(systemName: "pencil")
        }
        .tint(.blue)
    }
}

#Preview {
    LifeItemListView(
        repository: SwiftDataLifeItemRepository(
            modelContext: PreviewData.container.mainContext
        )
    )
    .modelContainer(PreviewData.container)
}
