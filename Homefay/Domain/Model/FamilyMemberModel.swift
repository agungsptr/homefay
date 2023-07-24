//
//  FamilyMember.swift
//  Homefay
//
//  Created by Agung Saputra on 20/07/23.
//

import Foundation

struct FamilyMemberModel: Identifiable {
    let id: UUID?
    var userId: String
    var name: String
    var username: String
    var isSupervisor: Bool
    var isLeader: Bool
}
