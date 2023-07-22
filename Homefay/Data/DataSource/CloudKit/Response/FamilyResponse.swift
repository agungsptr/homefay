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
    let name: String
    let uniqueId: String
    let createdBy: String
}

enum FamilyKeys: String {
    case type = "Family"
    case id
    case name
    case uniqueId
    case createdBy
}

extension FamilyResponse {
    init?(record: CKRecord) {
        guard
            let name = record[FamilyKeys.name.rawValue] as? String,
            let uniqueId = record[FamilyKeys.uniqueId.rawValue] as? String,
            let createdBy = record[FamilyKeys.createdBy.rawValue] as? String
        else {
            return nil
        }
        
        self.init(
            id: record.recordID,
            name: name,
            uniqueId: uniqueId,
            createdBy: createdBy
        )
    }
}

extension FamilyResponse {
    var record: CKRecord {
        let record = CKRecord(recordType: FamilyKeys.type.rawValue)
        record[FamilyKeys.name.rawValue] = name
        record[FamilyKeys.uniqueId.rawValue] = uniqueId
        record[FamilyKeys.createdBy.rawValue] = createdBy
        return record
    }
    
    var toModel: FamilyModel {
        FamilyModel(
            id: UUID(uuidString: id!.recordName),
            name: name,
            uniqueId: uniqueId,
            createdBy: createdBy
        )
    }
}
