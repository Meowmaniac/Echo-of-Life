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
    
    init(repository: LifeItemRepository) {
        _viewModel = State(
            initialValue: LifeItemListViewModel(repository: repository)
        )
    }
    
    var body: some View {
        NavigationStack {
            List(lifeItems, id: \.id) { lifeItem in
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
                            }
                            Spacer()
                            if lifeItem.isAchievement {
                                Image(systemName: "star.fill")
                            }
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
