//
//  TaskListRepository.swift
//  Homefay
//
//  Created by Agung Saputra on 26/07/23.
//

import Foundation

protocol TaskListRepository {
    func findAll(familyId: UUID) async throws -> [TaskListModel]
    func create(taskList: TaskListModel) async throws -> TaskListModel
    func delete(id: UUID) async throws -> Void
    func update(id: UUID, taskList: TaskListModel) async throws -> TaskListModel
}
