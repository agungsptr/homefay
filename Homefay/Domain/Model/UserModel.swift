//
//  UserModel.swift
//  Homefay
//
//  Created by Agung Saputra on 24/07/23.
//

import Foundation

struct UserModel: Identifiable {
    let id: UUID?
    var name: String
    var username: String
}
