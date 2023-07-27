//
//  ProfileUseCase.swift
//  Homefay
//
//  Created by Agung Saputra on 27/07/23.
//

import Foundation

protocol ProfileUseCase {
    func find(userId: UUID) async -> Result<ProfileModel, FetchDataError>
    func create(profile: ProfileModel) async -> Result<ProfileModel, FetchDataError>
    func delete(id: UUID) async -> Result<Bool, FetchDataError>
    func update(id: UUID, profile: ProfileModel) async -> Result<Bool, FetchDataError>
}

struct ProfileUseCaseImpl: ProfileUseCase {
    var repository: ProfileRepository
    
    func find(userId: UUID) async -> Result<ProfileModel, FetchDataError> {
        do {
            let data = try await repository.find(userId: userId)
            return .success(data)
        } catch {
            print(error.localizedDescription)
            return .failure(.FetchError)
        }
    }
    
    func create(profile: ProfileModel) async -> Result<ProfileModel, FetchDataError> {
        do {
            let data = try await repository.create(profile: profile)
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
    
    func update(id: UUID, profile: ProfileModel) async -> Result<Bool, FetchDataError> {
        do {
            let _ = try await repository.update(id: id, profile: profile)
            return .success(true)
        } catch {
            print(error.localizedDescription)
            return .failure(.CreateError)
        }
    }
}
