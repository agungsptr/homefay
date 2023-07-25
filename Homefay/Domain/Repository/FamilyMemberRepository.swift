//
//  FamilyMemberRepository.swift
//  Homefay
//
//  Created by Agung Saputra on 26/07/23.
//

import Foundation

protocol FamilyMemberRepository {
    func findAll() async throws -> [FamilyMemberModel]
    func create(familyMember: FamilyMemberModel) async throws -> FamilyMemberModel
    func delete(id: UUID) async throws -> Void
}
