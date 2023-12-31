//
//  FamilyCloudKitImpl.swift
//  Homefay
//
//  Created by Agung Saputra on 21/07/23.
//

import Foundation
import CloudKit

struct FamilyCloudKitImpl: FamilyDataSource {
    private let container = CKContainer.default().publicCloudDatabase
    
    private func uuidToCKRecordId(_ uuid: UUID) -> CKRecord.ID {
        // Create a CKRecordZone.ID with the default zone
        let zoneID = CKRecordZone.ID(zoneName: CKRecordZone.ID.defaultZoneName)
        
        // Create the CKRecord.ID using the provided UUID string and the zoneID
        let recordID = CKRecord.ID(recordName: uuid.uuidString, zoneID: zoneID)
        
        return recordID
    }
    
    func findByCode(familyCode: String) async throws -> FamilyModel {
        let query = CKQuery(
            recordType: FamilyKeys.type.rawValue,
            predicate: NSPredicate(format: "uniqueId == %@", familyCode)
        )
        query.sortDescriptors = []
        
        let result = try await container.records(matching: query)
        let records = result.matchResults.compactMap{ try? $0.1.get() }
        
        guard let res = FamilyResponse(record: records[0]) else {
            throw CKError(.unknownItem)
        }
        return res.toModel
    }
    
    func findAll() async throws -> [FamilyModel] {
        let query = CKQuery(
            recordType: FamilyKeys.type.rawValue,
            predicate: NSPredicate(value: true)
        )
        query.sortDescriptors = []
        
        let result = try await container.records(matching: query)
        let records = result.matchResults.compactMap{ try? $0.1.get() }
        
        var families: [FamilyModel] = []
        for record in records {
            guard let family = FamilyResponse(record: record) else {
                continue
            }
            families.append(family.toModel)
        }
        
        return families
    }
    
    func create(family: FamilyModel) async throws -> FamilyModel {
        guard let familyResponse = FamilyResponse(model: family) else {
            throw CKError(.unknownItem)
        }
        let req = try await container.save(familyResponse.record)
        
        try await Task.sleep(nanoseconds: 1_000_000_000)
        guard let res = FamilyResponse(record: req) else {
            throw CKError(.unknownItem)
        }
        return res.toModel
    }
    
    func update(id: UUID, family: FamilyModel) async throws -> FamilyModel {
        let record = try await container.record(for: uuidToCKRecordId(id))
        record[FamilyKeys.name.rawValue] = family.name
        let req = try await container.save(record)
        guard let res = FamilyResponse(record: req) else {
            throw CKError(.unknownItem)
        }
        return res.toModel
    }
    
    func delete(id: UUID) async throws {
        let recordId = uuidToCKRecordId(id)
        try await container.deleteRecord(withID: recordId)
    }
}
