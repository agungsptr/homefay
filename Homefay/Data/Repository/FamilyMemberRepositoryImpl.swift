//
//  FamilyMemberRepositoryImpl.swift
//  Homefay
//
//  Created by Agung Saputra on 26/07/23.
//

import Foundation

struct FamilyMemberRepositoryImpl: FamilyMemberRepository {
    var dataSource: FamilyMemberDataSource
    
    func findAll() async throws -> [FamilyMemberModel] {
        let data = try await dataSource.findAll()
        return data
    }
    
    func create(familyMember: FamilyMemberModel) async throws -> FamilyMemberModel {
        let req = try await dataSource.create(familyMember: familyMember)
        return req
    }
    
    func delete(id: UUID) async throws {
        try await dataSource.delete(id: id)
    }
}
