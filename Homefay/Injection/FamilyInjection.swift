//
//  TodoInjection.swift
//  CleanSwift
//
//  Created by Agung Saputra on 16/07/23.
//

import Foundation

struct FamilyInjec {
    func useCase() -> FamilyUseCase {
        let repo = FamilyRepositoryImpl(dataSource: FamilyCloudKitImpl())
        return FamilyUseCaseImpl(repository: repo)
    }
}
