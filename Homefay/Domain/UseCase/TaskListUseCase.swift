//
//  TaskListUseCase.swift
//  Homefay
//
//  Created by Agung Saputra on 26/07/23.
//

import Foundation

protocol TaskListUseCase {
    func findAll() async -> Result<[TaskListModel], FetchDataError>
    func create(taskList: TaskListModel) async -> Result<TaskListModel, FetchDataError>
    func delete(id: UUID) async -> Result<Bool, FetchDataError>
    func update(id: UUID, taskList: TaskListModel) async -> Result<Bool, FetchDataError>
}

struct TaskListUseCaseImpl: TaskListUseCase {
    var repository: TaskListRepository
    
    func findAll() async -> Result<[TaskListModel], FetchDataError> {
        do {
            let data = try await repository.findAll()
            return .success(data)
        } catch {
            print(error.localizedDescription)
            return .failure(.FetchError)
        }
    }
    
    func create(taskList: TaskListModel) async -> Result<TaskListModel, FetchDataError> {
        do {
            let data = try await repository.create(taskList: taskList)
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
    
    func update(id: UUID, taskList: TaskListModel) async -> Result<Bool, FetchDataError> {
        do {
            let _ = try await repository.update(id: id, taskList: taskList)
            return .success(true)
        } catch {
            print(error.localizedDescription)
            return .failure(.CreateError)
        }
    }
}
