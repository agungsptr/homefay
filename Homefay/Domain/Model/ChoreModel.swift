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
    var startTime: String
    var endTime: String
    var asignee: [UserModel]
    var depend: [String]
}
