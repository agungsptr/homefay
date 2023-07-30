//
//  ChoreInjection.swift
//  Homefay
//
//  Created by Agung Saputra on 26/07/23.
//

import Foundation

struct ChoreInjec {
    func useCase() -> ChoreUseCase {
        let repo = ChoreRepositoryImpl(dataSource: ChoreCloudKitImpl())
        return ChoreUseCaseImpl(repository: repo)
    }
}
