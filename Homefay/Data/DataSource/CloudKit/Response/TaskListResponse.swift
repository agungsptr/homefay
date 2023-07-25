//
//  TaskListResponse.swift
//  Homefay
//
//  Created by Agung Saputra on 26/07/23.
//

import Foundation
import CloudKit

struct TaskListResponse {
    var id: CKRecord.ID?
    var name: String
    var asigneeName: String
    var asigneeId: String
}

enum TaskListKeys: String {
    case type = "TaskList"
    case id
    case name
    case asigneeName
    case asigneeId
}

extension TaskListResponse {
    init?(record: CKRecord) {
        guard
            let name = record[TaskListKeys.name.rawValue] as? String,
            let asigneeName = record[TaskListKeys.asigneeName.rawValue] as? String,
            let asigneeId = record[TaskListKeys.asigneeId.rawValue] as? String
        else {
            return nil
        }
        
        self.init(
            id: record.recordID,
            name: name,
            asigneeName: asigneeName,
            asigneeId: asigneeId
        )
    }
}

extension TaskListResponse {
    init?(model: TaskListModel) {
        self.init(
            name: model.name,
            asigneeName: model.asigneeName,
            asigneeId: model.asigneeId
        )
    }
}

extension TaskListResponse {
    var record: CKRecord {
        let record = CKRecord(recordType: TaskListKeys.type.rawValue)
        record[TaskListKeys.name.rawValue] = name
        record[TaskListKeys.asigneeName.rawValue] = asigneeName
        record[TaskListKeys.asigneeId.rawValue] = asigneeId
        return record
    }
    
    var toModel: TaskListModel {
        TaskListModel(
            id: UUID(uuidString: id!.recordName),
            name: name,
            asigneeName: asigneeName,
            asigneeId: asigneeId
        )
    }
}
