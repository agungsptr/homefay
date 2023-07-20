//
//  File.swift
//  CleanSwift
//
//  Created by Agung Saputra on 17/07/23.
//

import Foundation

protocol FamilyUseCase {
    func findAll() -> Result<[FamilyModel], FetchDataError>
    func create(family: FamilyModel) -> Result<FamilyModel, FetchDataError>
}

struct FamilyUseCaseImpl: FamilyUseCase {
    var repository: FamilyRepository
    
    func findAll() -> Result<[FamilyModel], FetchDataError> {
        do {
            let data = try repository.findAll()
            return .success(data)
        } catch {
            return .failure(.FetchError)
        }
    }
    
    func create(family: FamilyModel) -> Result<FamilyModel, FetchDataError> {
        do {
            let data = try repository.create(family: family)
            return .success(data)
        } catch {
            return .failure(.CreateError)
        }
    }
}
