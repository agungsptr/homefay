//
//  ChoreList.swift
//  Homefay
//
//  Created by Agung Saputra on 20/07/23.
//

import Foundation

struct ChoreListModel: Identifiable {
    let id: UUID?
    var name: String
    var createdBy: UserModel
}
