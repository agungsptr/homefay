//
//  UserRepository.swift
//  Homefay
//
//  Created by Agung Saputra on 25/07/23.
//

import Foundation

protocol UserRepository {
    func findAll() async throws -> [UserModel]
    func create(user: UserModel) async throws -> UserModel
    func delete(id: UUID) async throws -> Void
    func update(id: UUID, user: UserModel) async throws -> UserModel
}
