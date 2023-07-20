//
//  Chore.swift
//  Homefay
//
//  Created by Agung Saputra on 20/07/23.
//

import Foundation

struct ChoreModel: Identifiable {
    let id: UUID
    let title: String
    let level: String
    let startTime: String
    let endTime: String
    let asignee: [String]
    let depend: [String]
    let createdBy: [String]
}
