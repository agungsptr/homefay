//
//  FamilyCloudKitImpl.swift
//  Homefay
//
//  Created by Agung Saputra on 21/07/23.
//

import Foundation
import CloudKit

struct FamilyResponse {
    var id: CKRecord.ID?
    var name: String
    var uniqueId: String
    var nameCreatedBy: String
    var usernameCreatedBy: String
    var idCreatedBy: String
}

enum FamilyKeys: String {
    case type = "Family"
    case id
    case name
    case uniqueId
    case nameCreatedBy
    case usernameCreatedBy
    case idCreatedBy
}

extension FamilyResponse {
    init?(record: CKRecord) {
        guard
            let name = record[FamilyKeys.name.rawValue] as? String,
            let uniqueId = record[FamilyKeys.uniqueId.rawValue] as? String,
            let nameCreatedBy = record[FamilyKeys.nameCreatedBy.rawValue] as? String,
            let usernameCreatedBy = record[FamilyKeys.usernameCreatedBy.rawValue] as? String,
            let idCreatedBy = record[FamilyKeys.idCreatedBy.rawValue] as? String
        else {
            return nil
        }
        
        self.init(
            id: record.recordID,
            name: name,
            uniqueId: uniqueId,
            nameCreatedBy: nameCreatedBy,
            usernameCreatedBy: usernameCreatedBy,
            idCreatedBy: idCreatedBy
        )
    }
}

extension FamilyResponse {
    init?(model: FamilyModel) {
        self.init(
            name: model.name,
            uniqueId: model.uniqueId,
            nameCreatedBy: model.createdBy.name,
            usernameCreatedBy: model.createdBy.username,
            idCreatedBy: model.createdBy.id!.uuidString
        )
    }
}

extension FamilyResponse {
    var record: CKRecord {
        let record = CKRecord(recordType: FamilyKeys.type.rawValue)
        record[FamilyKeys.name.rawValue] = name
        record[FamilyKeys.uniqueId.rawValue] = uniqueId
        record[FamilyKeys.nameCreatedBy.rawValue] = nameCreatedBy
        record[FamilyKeys.usernameCreatedBy.rawValue] = usernameCreatedBy
        record[FamilyKeys.idCreatedBy.rawValue] = idCreatedBy
        return record
    }
    
    var toModel: FamilyModel {
        FamilyModel(
            id: UUID(uuidString: id!.recordName),
            name: name,
            uniqueId: uniqueId,
            createdBy: UserModel(
                id: UUID(uuidString: idCreatedBy),
                name: nameCreatedBy,
                username: usernameCreatedBy
            )
        )
    }
}
