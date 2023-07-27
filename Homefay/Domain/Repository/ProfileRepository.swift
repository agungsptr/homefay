//
//  ProfileRepository.swift
//  Homefay
//
//  Created by Agung Saputra on 27/07/23.
//

import Foundation

protocol ProfileRepository {
    func find(userId: UUID) async throws -> ProfileModel
    func create(profile: ProfileModel) async throws -> ProfileModel
    func delete(id: UUID) async throws -> Void
    func update(id: UUID, profile: ProfileModel) async throws -> ProfileModel
}
