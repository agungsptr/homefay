//
//  ChoreRepository.swift
//  Homefay
//
//  Created by Agung Saputra on 26/07/23.
//

import Foundation

protocol ChoreRepository {
    func findAll(familyId: UUID) async throws -> [ChoreModel]
    func create(chore: ChoreModel) async throws -> ChoreModel
    func delete(id: UUID) async throws -> Void
    func update(id: UUID, chore: ChoreModel) async throws -> ChoreModel
}
