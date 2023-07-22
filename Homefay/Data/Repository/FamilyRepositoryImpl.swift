//
//  TodoRepositoryImpl.swift
//  CleanSwift
//
//  Created by Agung Saputra on 16/07/23.
//

import Foundation

struct FamilyRepositoryImpl: FamilyRepository {
    var dataSource: FamilyDataSource
    
    func findAll() async throws -> [FamilyModel] {
        let data = try await dataSource.findAll()
        return data
    }
    
    func create(family: FamilyModel) async throws -> FamilyModel {
        try await dataSource.create(family: family)
        return family
    }
    
    func delete(id: UUID) async throws {
        try await dataSource.delete(id: id)
    }
}
