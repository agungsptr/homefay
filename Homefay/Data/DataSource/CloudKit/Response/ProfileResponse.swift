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
    var familyId: String
    var name: String?
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
    case familyId
    case name
}

extension ProfileResponse {
    init?(record: CKRecord) {
        //        guard
        //            let interest = record[ProfileKeys.interest.rawValue] as? [String],
        //            let preference = record[ProfileKeys.preference.rawValue] as? [String],
        //            let availSun = record[ProfileKeys.availSun.rawValue] as? [Date],
        //            let availMon = record[ProfileKeys.availMon.rawValue] as? [Date],
        //            let availTue = record[ProfileKeys.availTue.rawValue] as? [Date],
        //            let availWed = record[ProfileKeys.availWed.rawValue] as? [Date],
        //            let availThu = record[ProfileKeys.availThu.rawValue] as? [Date],
        //            let availFri = record[ProfileKeys.availFri.rawValue] as? [Date],
        //            let availSat = record[ProfileKeys.availSat.rawValue] as? [Date],
        //            let dnd = record[ProfileKeys.dnd.rawValue] as? Bool,
        //            let userId = record[ProfileKeys.userId.rawValue] as? String,
        //            let avatar = record[ProfileKeys.avatar.rawValue] as? String,
        //            let familyId = record[ProfileKeys.familyId.rawValue] as? String,
        //            let name = record[ProfileKeys.name.rawValue] as? String
        //        else {
        //            return nil
        //        }
        
        self.init(
            id: record.recordID,
            interest: record[ProfileKeys.interest.rawValue] as? [String],
            preference: record[ProfileKeys.preference.rawValue] as? [String],
            availSun: record[ProfileKeys.availSun.rawValue] as? [Date],
            availMon: record[ProfileKeys.availMon.rawValue] as? [Date],
            availTue: record[ProfileKeys.availTue.rawValue] as? [Date],
            availWed: record[ProfileKeys.availWed.rawValue] as? [Date],
            availThu: record[ProfileKeys.availThu.rawValue] as? [Date],
            availFri: record[ProfileKeys.availFri.rawValue] as? [Date],
            availSat: record[ProfileKeys.availSat.rawValue] as? [Date],
            dnd: record[ProfileKeys.dnd.rawValue] as? Bool ?? false,
            userId: record[ProfileKeys.userId.rawValue] as? String ?? "",
            avatar: record[ProfileKeys.avatar.rawValue] as? String,
            familyId: record[ProfileKeys.familyId.rawValue] as? String ?? "",
            name: record[ProfileKeys.name.rawValue] as? String
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
            avatar: model.avatar,
            familyId: model.familyId,
            name: model.name
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
        record[ProfileKeys.familyId.rawValue] = familyId
        record[ProfileKeys.name.rawValue] = name
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
            avatar: avatar,
            familyId: familyId,
            name: name
        )
    }
}
