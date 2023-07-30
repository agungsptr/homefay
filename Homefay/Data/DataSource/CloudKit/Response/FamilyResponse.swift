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
    
    var idCreatedBy: String
    var nameCreatedBy: String
    var appleIdCreatedBy: String
    var emailCreatedBy: String
}

enum FamilyKeys: String {
    case type = "Family"
    case id
    case name
    case uniqueId
    case idCreatedBy
    case nameCreatedBy
    case appleIdCreatedBy
    case emailCreatedBy
}

extension FamilyResponse {
    init?(record: CKRecord) {
        guard
            let name = record[FamilyKeys.name.rawValue] as? String,
            let uniqueId = record[FamilyKeys.uniqueId.rawValue] as? String,
            let idCreatedBy = record[FamilyKeys.idCreatedBy.rawValue] as? String,
            let nameCreatedBy = record[FamilyKeys.nameCreatedBy.rawValue] as? String,
            let appleIdCreatedBy = record[FamilyKeys.appleIdCreatedBy.rawValue] as? String,
            let emailCreatedBy = record[FamilyKeys.emailCreatedBy.rawValue] as? String
        else {
            return nil
        }
        
        self.init(
            id: record.recordID,
            name: name,
            uniqueId: uniqueId,
            idCreatedBy: idCreatedBy,
            nameCreatedBy: nameCreatedBy,
            appleIdCreatedBy: appleIdCreatedBy,
            emailCreatedBy: emailCreatedBy
        )
    }
}

extension FamilyResponse {
    init?(model: FamilyModel) {
        self.init(
            name: model.name,
            uniqueId: model.uniqueId,
            idCreatedBy: model.createdBy.id!.uuidString,
            nameCreatedBy: model.createdBy.name ?? "",
            appleIdCreatedBy: model.createdBy.appleId,
            emailCreatedBy: model.createdBy.email ?? ""
        )
    }
}

extension FamilyResponse {
    var record: CKRecord {
        let record = CKRecord(recordType: FamilyKeys.type.rawValue)
        record[FamilyKeys.name.rawValue] = name
        record[FamilyKeys.uniqueId.rawValue] = uniqueId
        record[FamilyKeys.idCreatedBy.rawValue] = idCreatedBy
        record[FamilyKeys.nameCreatedBy.rawValue] = nameCreatedBy
        record[FamilyKeys.appleIdCreatedBy.rawValue] = appleIdCreatedBy
        record[FamilyKeys.emailCreatedBy.rawValue] = emailCreatedBy
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
                appleId: appleIdCreatedBy,
                email: emailCreatedBy
            )
        )
    }
}
