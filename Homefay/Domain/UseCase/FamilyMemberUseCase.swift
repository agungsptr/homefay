//
//  FamilyMemberUseCase.swift
//  Homefay
//
//  Created by Agung Saputra on 26/07/23.
//

import Foundation

protocol FamilyMemberUseCase {
    func findAll() async -> Result<[FamilyMemberModel], FetchDataError>
    func create(familyMember: FamilyMemberModel) async -> Result<FamilyMemberModel, FetchDataError>
    func delete(id: UUID) async -> Result<Bool, FetchDataError>
}

struct FamilyMemberUseCaseImpl: FamilyMemberUseCase {
    var repository: FamilyMemberRepository
    
    func findAll() async -> Result<[FamilyMemberModel], FetchDataError> {
        do {
            let data = try await repository.findAll()
            return .success(data)
        } catch {
            print(error.localizedDescription)
            return .failure(.FetchError)
        }
    }
    
    func create(familyMember: FamilyMemberModel) async -> Result<FamilyMemberModel, FetchDataError> {
        do {
            let data = try await repository.create(familyMember: familyMember)
            return .success(data)
        } catch {
            print(error.localizedDescription)
            return .failure(.CreateError)
        }
    }
    
    func delete(id: UUID) async -> Result<Bool, FetchDataError> {
        do {
            try await repository.delete(id: id)
            return .success(true)
        } catch {
            print(error.localizedDescription)
            return .failure(.CreateError)
        }
    }
}
