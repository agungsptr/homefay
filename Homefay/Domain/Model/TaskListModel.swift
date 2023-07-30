//
//  ChoreList.swift
//  Homefay
//
//  Created by Agung Saputra on 20/07/23.
//

import Foundation

struct TaskListModel: Identifiable {
    var id: UUID?
    var name: String
    var asigneeName: String
    var asigneeId: String
    var familyId: String
}
