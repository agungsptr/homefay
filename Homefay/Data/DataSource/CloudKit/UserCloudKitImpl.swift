//
//  UserCloudKitImpl.swift
//  Homefay
//
//  Created by Agung Saputra on 25/07/23.
//

import Foundation
import CloudKit

struct UserCloudKitImpl: UserDataSource {
    private let container = CKContainer.default().publicCloudDatabase
    
    private func uuidToCKRecordId(_ uuid: UUID) -> CKRecord.ID {
        // Create a CKRecordZone.ID with the default zone
        let zoneID = CKRecordZone.ID(zoneName: CKRecordZone.ID.defaultZoneName)
        
        // Create the CKRecord.ID using the provided UUID string and the zoneID
        let recordID = CKRecord.ID(recordName: uuid.uuidString, zoneID: zoneID)
        
        return recordID
    }
    
    func findAll() async throws -> [UserModel] {
        let query = CKQuery(
            recordType: FamilyKeys.type.rawValue,
            predicate: NSPredicate(value: true)
        )
        query.sortDescriptors = []
        
        let result = try await container.records(matching: query)
        let records = result.matchResults.compactMap{ try? $0.1.get() }
        
        var users: [UserModel] = []
        for record in records {
            guard let user = UserResponse(record: record) else {
                continue
            }
            users.append(user.toModel)
        }
        
        return users
    }
    
    func create(user: UserModel) async throws -> UserModel {
        guard let userResponse = UserResponse(model: user) else {
            throw CKError(.unknownItem)
        }
        let req = try await container.save(userResponse.record)
        
        try await Task.sleep(nanoseconds: 1_000_000_000)
        guard let res = UserResponse(record: req) else {
            throw CKError(.unknownItem)
        }
        return res.toModel
    }
    
    func update(id: UUID, user: UserModel) async throws -> UserModel {
        let record = try await container.record(for: uuidToCKRecordId(id))
        record[UserKeys.name.rawValue] = user.name
        record[UserKeys.appleId.rawValue] = user.appleId
        record[UserKeys.email.rawValue] = user.email
        let req = try await container.save(record)
        guard let res = UserResponse(record: req) else {
            throw CKError(.unknownItem)
        }
        return res.toModel
    }
    
    func delete(id: UUID) async throws {
        let recordId = uuidToCKRecordId(id)
        try await container.deleteRecord(withID: recordId)
    }
}
