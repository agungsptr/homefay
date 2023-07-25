//
//  FamilyMemberCloudKitImpl.swift
//  Homefay
//
//  Created by Agung Saputra on 26/07/23.
//

import Foundation
import CloudKit

struct FamilyMemberCloudKitImpl: FamilyMemberDataSource {
    private let container = CKContainer.default().publicCloudDatabase
    
    private func uuidToCKRecordId(_ uuid: UUID) -> CKRecord.ID {
        // Create a CKRecordZone.ID with the default zone
        let zoneID = CKRecordZone.ID(zoneName: CKRecordZone.ID.defaultZoneName)
        
        // Create the CKRecord.ID using the provided UUID string and the zoneID
        let recordID = CKRecord.ID(recordName: uuid.uuidString, zoneID: zoneID)
        
        return recordID
    }
    
    func findAll() async throws -> [FamilyMemberModel] {
        let query = CKQuery(
            recordType: FamilyMemberKeys.type.rawValue,
            predicate: NSPredicate(value: true)
        )
        query.sortDescriptors = []
        
        let result = try await container.records(matching: query)
        let records = result.matchResults.compactMap{ try? $0.1.get() }
        
        var familyMembers: [FamilyMemberModel] = []
        for record in records {
            guard let family = FamilyMemberResponse(record: record) else {
                continue
            }
            familyMembers.append(family.toModel)
        }

        return familyMembers
    }
    
    func create(familyMember: FamilyMemberModel) async throws -> FamilyMemberModel {
        guard let familyMemberResponse = FamilyMemberResponse(model: familyMember) else {
            throw CKError(.unknownItem)
        }
        let req = try await container.save(familyMemberResponse.record)
        
        try await Task.sleep(nanoseconds: 1_000_000_000)
        guard let res = FamilyMemberResponse(record: req) else {
            throw CKError(.unknownItem)
        }
        return res.toModel
    }
    
    func delete(id: UUID) async throws {
        let recordId = uuidToCKRecordId(id)
        try await container.deleteRecord(withID: recordId)
    }
}
