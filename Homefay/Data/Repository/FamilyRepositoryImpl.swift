//
//  TodoRepositoryImpl.swift
//  CleanSwift
//
//  Created by Agung Saputra on 16/07/23.
//

import Foundation

struct FamilyRepositoryImpl: FamilyRepository {
    var dataSource: FamilyDataSource
    
    func findAll() throws -> [FamilyModel] {
        let data = try dataSource.findAll()
        return data
    }
    
    func create(family: FamilyModel) throws -> FamilyModel {
        try dataSource.create(family: family)
        return family
    }
}
