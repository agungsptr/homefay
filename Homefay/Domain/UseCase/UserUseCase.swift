//
//  UserUseCase.swift
//  Homefay
//
//  Created by Agung Saputra on 25/07/23.
//

import Foundation

protocol UserUseCase {
    func findAll() async -> Result<[UserModel], FetchDataError>
    func create(user: UserModel) async -> Result<UserModel, FetchDataError>
    func delete(id: UUID) async -> Result<Bool, FetchDataError>
    func update(id: UUID, user: UserModel) async -> Result<Bool, FetchDataError>
}

struct UserUseCaseImpl: UserUseCase {
    var repository: UserRepository
    
    func findAll() async -> Result<[UserModel], FetchDataError> {
        do {
            let data = try await repository.findAll()
            return .success(data)
        } catch {
            print(error.localizedDescription)
            return .failure(.FetchError)
        }
    }
    
    func create(user: UserModel) async -> Result<UserModel, FetchDataError> {
        do {
            let data = try await repository.create(user: user)
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
    
    func update(id: UUID, user: UserModel) async -> Result<Bool, FetchDataError> {
        do {
            let _ = try await repository.update(id: id, user: user)
            return .success(true)
        } catch {
            print(error.localizedDescription)
            return .failure(.CreateError)
        }
    }
}
