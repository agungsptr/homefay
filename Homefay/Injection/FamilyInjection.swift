//
//  TodoInjection.swift
//  CleanSwift
//
//  Created by Agung Saputra on 16/07/23.
//

import Foundation

struct FamilyInjec {
    func useCase() -> FamilyUseCase {
        let repo = FamilyRepositoryImpl(dataSource: FamilyDataSourceImpl())
        return FamilyUseCaseImpl(repository: repo)
    }
}
