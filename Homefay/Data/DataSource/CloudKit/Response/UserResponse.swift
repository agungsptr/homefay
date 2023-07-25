//
//  UserResponse.swift
//  Homefay
//
//  Created by Agung Saputra on 25/07/23.
//

import Foundation
import CloudKit

struct UserResponse {
    var id: CKRecord.ID?
    var name: String
    var appleId: String
    var email: String
}

enum UserKeys: String {
    case type = "User"
    case id
    case name
    case appleId
    case email
}

extension UserResponse {
    init?(record: CKRecord) {
        guard
            let name = record[UserKeys.name.rawValue] as? String,
            let appleId = record[UserKeys.appleId.rawValue] as? String,
            let email = record[UserKeys.email.rawValue] as? String
        else {
            return nil
        }
        
        self.init(
            id: record.recordID,
            name: name,
            appleId: appleId,
            email: email
        )
    }
}

extension UserResponse {
    init?(model: UserModel) {
        self.init(
            name: model.name,
            appleId: model.appleId,
            email: model.email
        )
    }
}

extension UserResponse {
    var record: CKRecord {
        let record = CKRecord(recordType: UserKeys.type.rawValue)
        record[UserKeys.name.rawValue] = name
        record[UserKeys.appleId.rawValue] = appleId
        record[UserKeys.email.rawValue] = email
        return record
    }
    
    var toModel: UserModel {
        UserModel(
            id: UUID(uuidString: id!.recordName),
            name: name,
            appleId: appleId,
            email: email
        )
    }
}
