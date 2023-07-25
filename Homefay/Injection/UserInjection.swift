//
//  UserInjection.swift
//  Homefay
//
//  Created by Agung Saputra on 25/07/23.
//

import Foundation

struct UserInjec {
    func useCase() -> UserUseCase {
        let repo = UserRepositoryImpl(dataSource: UserCloudKitImpl())
        return UserUseCaseImpl(repository: repo)
    }
}
