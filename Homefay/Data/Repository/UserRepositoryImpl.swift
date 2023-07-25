//
//  UserRepositoryImpl.swift
//  Homefay
//
//  Created by Agung Saputra on 25/07/23.
//

import Foundation

struct UserRepositoryImpl: UserRepository {
    var dataSource: UserDataSource
    
    func findAll() async throws -> [UserModel] {
        let data = try await dataSource.findAll()
        return data
    }
    
    func create(user: UserModel) async throws -> UserModel {
        let req = try await dataSource.create(user: user)
        return req
    }
    
    func delete(id: UUID) async throws {
        try await dataSource.delete(id: id)
    }
    
    func update(id: UUID, user: UserModel) async throws -> UserModel {
        let req = try await dataSource.update(id: id, user: user)
        return req
    }
}
