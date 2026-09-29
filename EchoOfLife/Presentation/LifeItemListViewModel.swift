//
//  LifeItemViewModel.swift
//  EchoOfLife
//
//  Created by Kateryna Pavlova on 29/09/2026.
//

import Foundation

@Observable
final class LifeItemListViewModel {
    private let repository: LifeItemRepository
    var items: [LifeItem] = []
    var errorMessage: String?
    
    init(repository: LifeItemRepository) {
        self.repository = repository
    }
    
    func saveLifeItem(_ item: LifeItem) {
        do {
            errorMessage = nil
            try repository.save(item)
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    
    func deleteLifeItem(_ item: LifeItem) {
        do {
            errorMessage = nil
            try repository.delete(item)
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
