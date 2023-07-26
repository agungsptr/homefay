//
//  ChoreRepositoryImpl.swift
//  Homefay
//
//  Created by Agung Saputra on 26/07/23.
//

import Foundation

struct ChoreRepositoryImpl: ChoreRepository {
    var dataSource: ChoreDataSource
    
    func findAll() async throws -> [ChoreModel] {
        let data = try await dataSource.findAll()
        return data
    }
    
    func create(chore: ChoreModel) async throws -> ChoreModel {
        let req = try await dataSource.create(chore: chore)
        return req
    }
    
    func delete(id: UUID) async throws {
        try await dataSource.delete(id: id)
    }
    
    func update(id: UUID, chore: ChoreModel) async throws -> ChoreModel {
        let req = try await dataSource.update(id: id, chore: chore)
        return req
    }
}
