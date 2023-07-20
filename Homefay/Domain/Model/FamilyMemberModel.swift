//
//  FamilyMember.swift
//  Homefay
//
//  Created by Agung Saputra on 20/07/23.
//

import Foundation

struct FamilyMemberModel: Identifiable {
    let id: UUID
    let name: String
    let username: String
    let isSupervisor: Bool
    let isLeader: Bool
}
