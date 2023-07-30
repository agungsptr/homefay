//
//  TaskListInjection.swift
//  Homefay
//
//  Created by Agung Saputra on 26/07/23.
//

import Foundation

struct TaskListInjec {
    func useCase() -> TaskListUseCase {
        let repo = TaskListRepositoryImpl(dataSource: TaskListCloudKitImpl())
        return TaskListUseCaseImpl(repository: repo)
    }
}
