//
//  TodoCoreDataImpl.swift
//  CleanSwift
//
//  Created by Agung Saputra on 16/07/23.
//

import Foundation

protocol FamilyDataSource {
    func findAll() async throws -> [FamilyModel]
    func create(family: FamilyModel) async throws -> Void
    func delete(id: UUID) async throws -> Void
}

