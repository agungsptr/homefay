//
//  FamilyMember.swift
//  Homefay
//
//  Created by Agung Saputra on 20/07/23.
//

import Foundation

struct FamilyMemberModel: Identifiable, Hashable {
    var id: UUID?
    var familyId: String
    var name: String
    var role: String
    var userId: String
}
