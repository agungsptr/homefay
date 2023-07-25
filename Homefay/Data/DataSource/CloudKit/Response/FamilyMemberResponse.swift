//
//  FamilyMemberResponse.swift
//  Homefay
//
//  Created by Agung Saputra on 25/07/23.
//

import Foundation
import CloudKit

struct FamilyMemberResponse {
    var id: CKRecord.ID?
    var familyId: String
    var name: String
    var role: String
    var userId: String
}

enum FamilyMemberKeys: String {
    case type = "FamilyMember"
    case id
    case familyId
    case name
    case role
    case userId
}

extension FamilyMemberResponse {
    init?(record: CKRecord) {
        guard
            let familyId = record[FamilyMemberKeys.familyId.rawValue] as? String,
            let name = record[FamilyMemberKeys.name.rawValue] as? String,
            let role = record[FamilyMemberKeys.role.rawValue] as? String,
            let userId = record[FamilyMemberKeys.userId.rawValue] as? String
        else {
            return nil
        }
        
        self.init(
            id: record.recordID,
            familyId: familyId,
            name: name,
            role: role,
            userId: userId
        )
    }
}

extension FamilyMemberResponse {
    init?(model: FamilyMemberModel) {
        self.init(
            familyId: model.familyId,
            name: model.name,
            role: model.role,
            userId: model.userId
        )
    }
}

extension FamilyMemberResponse {
    var record: CKRecord {
        let record = CKRecord(recordType: FamilyMemberKeys.type.rawValue)
        record[FamilyMemberKeys.familyId.rawValue] = familyId
        record[FamilyMemberKeys.name.rawValue] = name
        record[FamilyMemberKeys.role.rawValue] = role
        record[FamilyMemberKeys.userId.rawValue] = userId
        return record
    }
    
    var toModel: FamilyMemberModel {
        FamilyMemberModel(
            id: UUID(uuidString: id!.recordName),
            familyId: familyId,
            name: name,
            role: role,
            userId: userId
        )
    }
}
