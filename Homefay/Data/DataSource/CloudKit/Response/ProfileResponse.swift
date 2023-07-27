//
//  ProfileResponse.swift
//  Homefay
//
//  Created by Agung Saputra on 27/07/23.
//

import Foundation
import CloudKit

struct ProfileResponse {
    var id: CKRecord.ID?
    var interest: [String]?
    var preference: [String]?
    var availSun: [Date]? // 0->StartDate 1->EndDate
    var availMon: [Date]?
    var availTue: [Date]?
    var availWed: [Date]?
    var availThu: [Date]?
    var availFri: [Date]?
    var availSat: [Date]?
    var dnd: Bool
    var userId: String
    var avatar: String?
}

enum ProfileKeys: String {
    case type = "Profile"
    case id
    case interest
    case preference
    case availSun
    case availMon
    case availTue
    case availWed
    case availThu
    case availFri
    case availSat
    case dnd
    case userId
    case avatar
}

extension ProfileResponse {
    init?(record: CKRecord) {
        guard
            let interest = record[ProfileKeys.interest.rawValue] as? [String],
            let preference = record[ProfileKeys.preference.rawValue] as? [String],
            let availSun = record[ProfileKeys.availSun.rawValue] as? [Date],
            let availMon = record[ProfileKeys.availMon.rawValue] as? [Date],
            let availTue = record[ProfileKeys.availTue.rawValue] as? [Date],
            let availWed = record[ProfileKeys.availWed.rawValue] as? [Date],
            let availThu = record[ProfileKeys.availThu.rawValue] as? [Date],
            let availFri = record[ProfileKeys.availFri.rawValue] as? [Date],
            let availSat = record[ProfileKeys.availSat.rawValue] as? [Date],
            let dnd = record[ProfileKeys.dnd.rawValue] as? Bool,
            let userId = record[ProfileKeys.userId.rawValue] as? String,
            let avatar = record[ProfileKeys.avatar.rawValue] as? String
        else {
            return nil
        }
        
        self.init(
            id: record.recordID,
            interest: interest,
            preference: preference,
            availSun: availSun,
            availMon: availMon,
            availTue: availTue,
            availWed: availWed,
            availThu: availThu,
            availFri: availFri,
            availSat: availSat,
            dnd: dnd,
            userId: userId,
            avatar: avatar
        )
    }
}

extension ProfileResponse {
    init?(model: ProfileModel) {
        self.init(
            interest: model.interest,
            preference: model.preference,
            availSun: model.availSun,
            availMon: model.availMon,
            availTue: model.availTue,
            availWed: model.availWed,
            availThu: model.availThu,
            availFri: model.availFri,
            availSat: model.availSat,
            dnd: model.dnd,
            userId: model.userId,
            avatar: model.avatar
        )
    }
}

extension ProfileResponse {
    var record: CKRecord {
        let record = CKRecord(recordType: ProfileKeys.type.rawValue)
        record[ProfileKeys.interest.rawValue] = interest
        record[ProfileKeys.preference.rawValue] = preference
        record[ProfileKeys.availSun.rawValue] = availSun
        record[ProfileKeys.availMon.rawValue] = availMon
        record[ProfileKeys.availTue.rawValue] = availTue
        record[ProfileKeys.availWed.rawValue] = availWed
        record[ProfileKeys.availThu.rawValue] = availThu
        record[ProfileKeys.availFri.rawValue] = availFri
        record[ProfileKeys.availSat.rawValue] = availSat
        record[ProfileKeys.dnd.rawValue] = dnd
        record[ProfileKeys.userId.rawValue] = userId
        record[ProfileKeys.avatar.rawValue] = avatar
        return record
    }
    
    var toModel: ProfileModel {
        ProfileModel(
            id: UUID(uuidString: id!.recordName),
            interest: interest,
            preference: preference,
            availSun: availSun,
            availMon: availMon,
            availTue: availTue,
            availWed: availWed,
            availThu: availThu,
            availFri: availFri,
            availSat: availSat,
            dnd: dnd,
            userId: userId,
            avatar: avatar
        )
    }
}
