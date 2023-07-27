//
//  ChoreCloudKitImpl.swift
//  Homefay
//
//  Created by Agung Saputra on 26/07/23.
//

import Foundation
import CloudKit

struct ChoreCloudKitImpl: ChoreDataSource {
    private let container = CKContainer.default().publicCloudDatabase
    
    private func uuidToCKRecordId(_ uuid: UUID) -> CKRecord.ID {
        // Create a CKRecordZone.ID with the default zone
        let zoneID = CKRecordZone.ID(zoneName: CKRecordZone.ID.defaultZoneName)
        
        // Create the CKRecord.ID using the provided UUID string and the zoneID
        let recordID = CKRecord.ID(recordName: uuid.uuidString, zoneID: zoneID)
        
        return recordID
    }
    
    func findAll() async throws -> [ChoreModel] {
        let query = CKQuery(
            recordType: ChoreKeys.type.rawValue,
            predicate: NSPredicate(value: true)
        )
        query.sortDescriptors = []
        
        let result = try await container.records(matching: query)
        let records = result.matchResults.compactMap{ try? $0.1.get() }
        
        var families: [ChoreModel] = []
        for record in records {
            guard let chore = ChoreResponse(record: record) else {
                continue
            }
            families.append(chore.toModel)
        }
        
        return families
    }
    
    func create(chore: ChoreModel) async throws -> ChoreModel {
        guard let choreResponse = ChoreResponse(model: chore) else {
            throw CKError(.unknownItem)
        }
        let req = try await container.save(choreResponse.record)
        
        try await Task.sleep(nanoseconds: 1_000_000_000)
        guard let res = ChoreResponse(record: req) else {
            throw CKError(.unknownItem)
        }
        return res.toModel
    }
    
    func update(id: UUID, chore: ChoreModel) async throws -> ChoreModel {
        let record = try await container.record(for: uuidToCKRecordId(id))
        record[ChoreKeys.title.rawValue] = chore.title
        record[ChoreKeys.category.rawValue] = chore.category
        record[ChoreKeys.level.rawValue] = chore.level
        record[ChoreKeys.startTime.rawValue] = chore.startTime
        record[ChoreKeys.endTime.rawValue] = chore.endTime
        record[ChoreKeys.depend.rawValue] = chore.depend
        record[ChoreKeys.isDone.rawValue] = chore.isDone
        record[ChoreKeys.listId.rawValue] = chore.listId
        
        var parserAsignee: [String] = []
        for asign in chore.asignee {
            let str = "\(asign.id?.uuidString ?? ""),\(asign.familyId),\(asign.name),\(asign.role),\(asign.userId)"
            parserAsignee.append(str)
        }
        record[ChoreKeys.asignee.rawValue] = parserAsignee
        
        let req = try await container.save(record)
        guard let res = ChoreResponse(record: req) else {
            throw CKError(.unknownItem)
        }
        return res.toModel
    }
    
    func delete(id: UUID) async throws {
        let recordId = uuidToCKRecordId(id)
        try await container.deleteRecord(withID: recordId)
    }
}
