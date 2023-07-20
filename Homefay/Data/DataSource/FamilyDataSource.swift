//
//  TodoCoreDataImpl.swift
//  CleanSwift
//
//  Created by Agung Saputra on 16/07/23.
//

import Foundation

protocol FamilyDataSource {
    func findAll() throws -> [FamilyModel]
    func create(family: FamilyModel) throws -> ()
}

