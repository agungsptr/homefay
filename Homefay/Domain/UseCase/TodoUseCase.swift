//
//  File.swift
//  CleanSwift
//
//  Created by Agung Saputra on 17/07/23.
//

import Foundation

protocol FamilyUseCase {
    func findAll() async -> Result<[FamilyModel], FetchDataError>
    func create(family: FamilyModel) async -> Result<FamilyModel, FetchDataError>
    func delete(id: UUID) async -> Result<Bool, FetchDataError>
}

struct FamilyUseCaseImpl: FamilyUseCase {
    var repository: FamilyRepository
    
    func findAll() async -> Result<[FamilyModel], FetchDataError> {
        do {
            let data = try await repository.findAll()
            return .success(data)
        } catch {
            print(error.localizedDescription)
            return .failure(.FetchError)
        }
    }
    
    func create(family: FamilyModel) async -> Result<FamilyModel, FetchDataError> {
        do {
            let data = try await repository.create(family: family)
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
