//
//  ProfileModel.swift
//  Homefay
//
//  Created by Agung Saputra on 20/07/23.
//

import Foundation

struct ProfileModel: Identifiable, Hashable {
    var id: UUID?
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
