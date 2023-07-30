//
//  ChoreUseCase.swift
//  Homefay
//
//  Created by Agung Saputra on 26/07/23.
//

import Foundation

protocol ChoreUseCase {
    func findAll(familyId: UUID) async -> Result<[ChoreModel], FetchDataError>
    func create(chore: ChoreModel) async -> Result<ChoreModel, FetchDataError>
    func delete(id: UUID) async -> Result<Bool, FetchDataError>
    func update(id: UUID, chore: ChoreModel) async -> Result<Bool, FetchDataError>
}

struct ChoreUseCaseImpl: ChoreUseCase {
    var repository: ChoreRepository
    
    func findAll(familyId: UUID) async -> Result<[ChoreModel], FetchDataError> {
        do {
            let data = try await repository.findAll(familyId: familyId)
            return .success(data)
        } catch {
            print(error.localizedDescription)
            return .failure(.FetchError)
        }
    }
    
    func create(chore: ChoreModel) async -> Result<ChoreModel, FetchDataError> {
        do {
            let data = try await repository.create(chore: chore)
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
    
    func update(id: UUID, chore: ChoreModel) async -> Result<Bool, FetchDataError> {
        do {
            let _ = try await repository.update(id: id, chore: chore)
            return .success(true)
        } catch {
            print(error.localizedDescription)
            return .failure(.CreateError)
        }
    }
}
