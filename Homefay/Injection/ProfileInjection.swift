//
//  ProfileInjection.swift
//  Homefay
//
//  Created by Agung Saputra on 27/07/23.
//

import Foundation

struct ProfileInjec {
    func useCase() -> ProfileUseCase {
        let repo = ProfileRepositoryImpl(dataSource: ProfileCloudKitImpl())
        return ProfileUseCaseImpl(repository: repo)
    }
}
