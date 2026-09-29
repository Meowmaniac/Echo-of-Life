//
//  LifeItemRepository.swift
//  EchoOfLife
//
//  Created by Kateryna Pavlova on 28/09/2026.
//

import Foundation
import SwiftUI

protocol LifeItemRepository {
    func fetchAll() throws -> [LifeItem]
    func save(_ item: LifeItem) throws
    func delete(_ item: LifeItem) throws
}
