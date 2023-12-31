//
//  Todo.swift
//  CleanSwift
//
//  Created by Agung Saputra on 16/07/23.
//

import Foundation

struct FamilyModel: Identifiable {
    var id: UUID?
    var name: String
    var uniqueId: String
    var createdBy: UserModel
}
