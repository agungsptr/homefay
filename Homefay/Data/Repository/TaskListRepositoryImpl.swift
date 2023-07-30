//
//  TaskListRepositoryImpl.swift
//  Homefay
//
//  Created by Agung Saputra on 26/07/23.
//

import Foundation

struct TaskListRepositoryImpl: TaskListRepository {
    var dataSource: TaskListDataSource
    
    func findAll(familyId: UUID) async throws -> [TaskListModel] {
        let data = try await dataSource.findAll(familyId: familyId)
        return data
    }
    
    func create(taskList: TaskListModel) async throws -> TaskListModel {
        let req = try await dataSource.create(taskList: taskList)
        return req
    }
    
    func delete(id: UUID) async throws {
        try await dataSource.delete(id: id)
    }
    
    func update(id: UUID, taskList: TaskListModel) async throws -> TaskListModel {
        let req = try await dataSource.update(id: id, taskList: taskList)
        return req
    }
}
