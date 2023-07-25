//
//  FamilyMemberInjection.swift
//  Homefay
//
//  Created by Agung Saputra on 26/07/23.
//

import Foundation

struct FamilyMemberInjec {
    func useCase() -> FamilyMemberUseCase {
        let repo = FamilyMemberRepositoryImpl(dataSource: FamilyMemberCloudKitImpl())
        return FamilyMemberUseCaseImpl(repository: repo)
    }
}
