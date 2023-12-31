//
//  TodoCoreDataImpl.swift
//  CleanSwift
//
//  Created by Agung Saputra on 16/07/23.
//

import Foundation

protocol FamilyDataSource {
    func findAll() async throws -> [FamilyModel]
    func findByCode(familyCode: String) async throws -> FamilyModel
    func create(family: FamilyModel) async throws -> FamilyModel
    func delete(id: UUID) async throws -> Void
    func update(id: UUID, family: FamilyModel) async throws -> FamilyModel
}

