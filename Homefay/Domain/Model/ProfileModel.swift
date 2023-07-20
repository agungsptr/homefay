//
//  ProfileModel.swift
//  Homefay
//
//  Created by Agung Saputra on 20/07/23.
//

import Foundation

struct ScheduleHour {
    let sundayStart: String?
    let sundayEnd: String?
    let mondayStart: String?
    let mondayEnd: String?
    let tuesdayStart: String?
    let tuesdayEnd: String?
    let wednesdayStart: String?
    let wednesdayEnd: String?
    let thursdayStart: String?
    let thursdayEnd: String?
    let fridayStart: String?
    let fridayEnd: String?
    let saturdayStart: String?
    let saturdayEnd: String?
    
}

struct ProfileModel: Identifiable {
    let id: UUID
    let interest: [String]
    let availabilityHour: [ScheduleHour]?
    let availabilityStatus: String
    let createdBy: String
}
