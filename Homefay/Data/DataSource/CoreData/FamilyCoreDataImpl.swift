//
//  TodoCoreDataImpl.swift
//  CleanSwift
//
//  Created by Agung Saputra on 17/07/23.
//

import Foundation
import CoreData

struct FamilyDataSourceImpl: FamilyDataSource {
    private let container: NSPersistentContainer

    init() {
        container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores { description, error in
            if error != nil {
                fatalError("Cannot Load Core Data Model")
            }
        }
    }

    func findAll() throws -> [FamilyModel]{
        let request = Family.fetchRequest()
        return try container.viewContext.fetch(request).map({ data in
            FamilyModel(
                id: data.id!,
                name: data.name!,
                uniqueId: data.uniqueId!
            )
        })
    }

    func create(family: FamilyModel) throws -> (){
        let familyEntity = Family(context: container.viewContext)
        familyEntity.id = family.id
        familyEntity.name = family.name
        familyEntity.uniqueId = family.uniqueId
        saveContext()
    }

    private func saveContext(){
        let context = container.viewContext
        if context.hasChanges {
            do{
                try context.save()
            }catch{
                fatalError("Error: \(error.localizedDescription)")
            }
        }
    }
}
