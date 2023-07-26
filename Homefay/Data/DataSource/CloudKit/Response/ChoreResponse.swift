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
    var startTime: String
    var endTime: String
    var asignee: [String]
    var depend: [String]
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
}

extension ChoreResponse {
    init?(record: CKRecord) {
        guard
            let title = record[ChoreKeys.title.rawValue] as? String,
            let category = record[ChoreKeys.category.rawValue] as? String,
            let level = record[ChoreKeys.level.rawValue] as? String,
            let startTime = record[ChoreKeys.startTime.rawValue] as? String,
            let endTime = record[ChoreKeys.endTime.rawValue] as? String,
            let asignee = record[ChoreKeys.asignee.rawValue] as? [String],
            let depend = record[ChoreKeys.depend.rawValue] as? [String]
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
            depend: depend
        )
    }
}

extension ChoreResponse {
    init?(model: ChoreModel) {
        var parserAsignee: [String] = []
        for asign in model.asignee {
            let str = "\(asign.id?.uuidString ?? ""),\(asign.name),\(asign.appleId),\(asign.email)"
            parserAsignee.append(str)
        }
        
        self.init(
            title: model.title,
            category: model.category,
            level: model.level,
            startTime: model.startTime,
            endTime: model.endTime,
            asignee: parserAsignee,
            depend: model.depend
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
        return record
    }
    
    var toModel: ChoreModel {
        var parserAsignee: [UserModel] = []
        for asign in asignee {
            let arrData = asign.split(separator: ",")
            let user = UserModel(
                id: UUID(uuidString: "\(arrData[0])"),
                name: "\(arrData[1])",
                appleId: "\(arrData[2])",
                email: "\(arrData[3])"
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
            depend: depend
        )
    }
}
