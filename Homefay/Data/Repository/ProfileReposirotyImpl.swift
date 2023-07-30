//
//  ProfileReposirotyImpl.swift
//  Homefay
//
//  Created by Agung Saputra on 27/07/23.
//

import Foundation

struct ProfileRepositoryImpl: ProfileRepository {
    var dataSource: ProfileDataSource
    
    func findAll(familyId: UUID) async throws -> [ProfileModel] {
        let data = try await dataSource.findAll(familyId: familyId)
        return data
    }
    
    func find(userId: UUID) async throws -> ProfileModel {
        let data = try await dataSource.find(userId: userId)
        return data
    }
    
    func create(profile: ProfileModel) async throws -> ProfileModel {
        let req = try await dataSource.create(profile: profile)
        return req
    }
    
    func delete(id: UUID) async throws {
        try await dataSource.delete(id: id)
    }
    
    func update(id: UUID, profile: ProfileModel) async throws -> ProfileModel {
        let req = try await dataSource.update(id: id, profile: profile)
        return req
    }
}
