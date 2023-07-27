//
//  ProfileCloudKitImpl.swift
//  Homefay
//
//  Created by Agung Saputra on 27/07/23.
//

import Foundation
import CloudKit

struct ProfileCloudKitImpl: ProfileDataSource {
    private let container = CKContainer.default().publicCloudDatabase
    
    private func uuidToCKRecordId(_ uuid: UUID) -> CKRecord.ID {
        // Create a CKRecordZone.ID with the default zone
        let zoneID = CKRecordZone.ID(zoneName: CKRecordZone.ID.defaultZoneName)
        
        // Create the CKRecord.ID using the provided UUID string and the zoneID
        let recordID = CKRecord.ID(recordName: uuid.uuidString, zoneID: zoneID)
        
        return recordID
    }
    
    func find(userId: UUID) async throws -> ProfileModel {
        let record = try await container.record(for: uuidToCKRecordId(userId))
        guard let res = ProfileResponse(record: record) else {
            throw CKError(.unknownItem)
        }
        return res.toModel
    }
    
    func create(profile: ProfileModel) async throws -> ProfileModel {
        guard let userResponse = ProfileResponse(model: profile) else {
            throw CKError(.unknownItem)
        }
        let req = try await container.save(userResponse.record)
        
        try await Task.sleep(nanoseconds: 1_000_000_000)
        guard let res = ProfileResponse(record: req) else {
            throw CKError(.unknownItem)
        }
        return res.toModel
    }
    
    func update(id: UUID, profile: ProfileModel) async throws -> ProfileModel {
        let record = try await container.record(for: uuidToCKRecordId(id))
        record[ProfileKeys.interest.rawValue] = profile.interest
        record[ProfileKeys.preference.rawValue] = profile.preference
        record[ProfileKeys.availSun.rawValue] = profile.availSun
        record[ProfileKeys.availMon.rawValue] = profile.availMon
        record[ProfileKeys.availTue.rawValue] = profile.availTue
        record[ProfileKeys.availWed.rawValue] = profile.availWed
        record[ProfileKeys.availThu.rawValue] = profile.availThu
        record[ProfileKeys.availFri.rawValue] = profile.availFri
        record[ProfileKeys.availSat.rawValue] = profile.availSat
        record[ProfileKeys.dnd.rawValue] = profile.dnd
        record[ProfileKeys.userId.rawValue] = profile.userId
        record[ProfileKeys.avatar.rawValue] = profile.avatar
        
        let req = try await container.save(record)
        guard let res = ProfileResponse(record: req) else {
            throw CKError(.unknownItem)
        }
        return res.toModel
    }
    
    func delete(id: UUID) async throws {
        let recordId = uuidToCKRecordId(id)
        try await container.deleteRecord(withID: recordId)
    }
}
