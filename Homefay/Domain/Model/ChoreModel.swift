//
//  Chore.swift
//  Homefay
//
//  Created by Agung Saputra on 20/07/23.
//

import Foundation

struct ChoreModel: Identifiable {
    var id: UUID?
    var title: String
    var category: String
    var level: String
    var startTime: Date
    var endTime: Date
    var asignee: [FamilyMemberModel]
    var depend: [String]
    var isDone: Bool
}
