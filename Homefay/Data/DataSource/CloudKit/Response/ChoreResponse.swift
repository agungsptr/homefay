//
//  ChoreResponse.swift
//  Homefay
//
//  Created by Agung Saputra on 26/07/23.
//

import Foundation
import CloudKit

struct ChoreResponse {
    var id: CKRecord.ID?
    var title: String
    var category: String
    var level: String
    var startTime: Date
    var endTime: Date
    var asignee: [String]
    var depend: [String]
    var isDone: Bool
    var listId: String
}

enum ChoreKeys: String {
    case type = "Chore"
    case id
    case title
    case category
    case level
    case startTime
    case endTime
    case asignee
    case depend
    case isDone
    case listId
}

extension ChoreResponse {
    init?(record: CKRecord) {
        guard
            let title = record[ChoreKeys.title.rawValue] as? String,
            let category = record[ChoreKeys.category.rawValue] as? String,
            let level = record[ChoreKeys.level.rawValue] as? String,
            let startTime = record[ChoreKeys.startTime.rawValue] as? Date,
            let endTime = record[ChoreKeys.endTime.rawValue] as? Date,
            let asignee = record[ChoreKeys.asignee.rawValue] as? [String],
            let depend = record[ChoreKeys.depend.rawValue] as? [String],
            let isDone = record[ChoreKeys.isDone.rawValue] as? Bool,
            let listId = record[ChoreKeys.listId.rawValue] as? String
        else {
            return nil
        }
        
        self.init(
            id: record.recordID,
            title: title,
            category: category,
            level: level,
            startTime: startTime,
            endTime: endTime,
            asignee: asignee,
            depend: depend,
            isDone: isDone,
            listId: listId
        )
    }
}

extension ChoreResponse {
    init?(model: ChoreModel) {
        var parserAsignee: [String] = []
        for asign in model.asignee {
            let str = "\(asign.id?.uuidString ?? ""),\(asign.familyId),\(asign.name),\(asign.role),\(asign.userId)"
            parserAsignee.append(str)
        }
        
        self.init(
            title: model.title,
            category: model.category,
            level: model.level,
            startTime: model.startTime,
            endTime: model.endTime,
            asignee: parserAsignee,
            depend: model.depend,
            isDone: model.isDone,
            listId: model.listId
        )
    }
}

extension ChoreResponse {
    var record: CKRecord {
        let record = CKRecord(recordType: ChoreKeys.type.rawValue)
        record[ChoreKeys.title.rawValue] = title
        record[ChoreKeys.category.rawValue] = category
        record[ChoreKeys.level.rawValue] = level
        record[ChoreKeys.startTime.rawValue] = startTime
        record[ChoreKeys.endTime.rawValue] = endTime
        record[ChoreKeys.asignee.rawValue] = asignee
        record[ChoreKeys.depend.rawValue] = depend
        record[ChoreKeys.isDone.rawValue] = isDone
        record[ChoreKeys.listId.rawValue] = listId
        return record
    }
    
    var toModel: ChoreModel {
        var parserAsignee: [FamilyMemberModel] = []
        for asign in asignee {
            let arrData = asign.split(separator: ",")
            print("DEBUG: \(arrData)")
            let user = FamilyMemberModel(
                id: UUID(uuidString: "\(arrData[0])"),
                familyId: "\(arrData[1])",
                name: "\(arrData[2])",
                role: "\(arrData[3])",
                userId: "\(arrData[4])"
            )
            parserAsignee.append(user)
        }
        
        return ChoreModel(
            id: UUID(uuidString: id!.recordName),
            title: title,
            category: category,
            level: level,
            startTime: startTime,
            endTime: endTime,
            asignee: parserAsignee,
            depend: depend,
            isDone: isDone,
            listId: listId
        )
    }
}
