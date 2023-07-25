//
//  TaskListCloudKitImpl.swift
//  Homefay
//
//  Created by Agung Saputra on 26/07/23.
//

import Foundation
import CloudKit

struct TaskListCloudKitImpl: TaskListDataSource {
    private let container = CKContainer.default().publicCloudDatabase
    
    private func uuidToCKRecordId(_ uuid: UUID) -> CKRecord.ID {
        // Create a CKRecordZone.ID with the default zone
        let zoneID = CKRecordZone.ID(zoneName: CKRecordZone.ID.defaultZoneName)
        
        // Create the CKRecord.ID using the provided UUID string and the zoneID
        let recordID = CKRecord.ID(recordName: uuid.uuidString, zoneID: zoneID)
        
        return recordID
    }
    
    func findAll() async throws -> [TaskListModel] {
        let query = CKQuery(
            recordType: FamilyKeys.type.rawValue,
            predicate: NSPredicate(value: true)
        )
        query.sortDescriptors = []
        
        let result = try await container.records(matching: query)
        let records = result.matchResults.compactMap{ try? $0.1.get() }
        
        var taskLists: [TaskListModel] = []
        for record in records {
            guard let taskList = TaskListResponse(record: record) else {
                continue
            }
            taskLists.append(taskList.toModel)
        }
        
        return taskLists
    }
    
    func create(taskList: TaskListModel) async throws -> TaskListModel {
        guard let taskListResponse = TaskListResponse(model: taskList) else {
            throw CKError(.unknownItem)
        }
        let req = try await container.save(taskListResponse.record)
        
        try await Task.sleep(nanoseconds: 1_000_000_000)
        guard let res = TaskListResponse(record: req) else {
            throw CKError(.unknownItem)
        }
        return res.toModel
    }
    
    func update(id: UUID, taskList: TaskListModel) async throws -> TaskListModel {
        let record = try await container.record(for: uuidToCKRecordId(id))
        record[TaskListKeys.name.rawValue] = taskList.name
        record[TaskListKeys.asigneeName.rawValue] = taskList.asigneeName
        record[TaskListKeys.asigneeId.rawValue] = taskList.asigneeId
        let req = try await container.save(record)
        guard let res = TaskListResponse(record: req) else {
            throw CKError(.unknownItem)
        }
        return res.toModel
    }
    
    func delete(id: UUID) async throws {
        let recordId = uuidToCKRecordId(id)
        try await container.deleteRecord(withID: recordId)
    }
}
