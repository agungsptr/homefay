////
////  TodoCoreDataImpl.swift
////  CleanSwift
////
////  Created by Agung Saputra on 17/07/23.
////
//
//import Foundation
//import CoreData
//
//struct FamilyCoreDataImpl {
//    private let container: NSPersistentContainer
//
//    private func getEntityById(_ id: UUID) throws -> Family? {
//        let req = Family.fetchRequest()
//        req.fetchLimit = 1
//        req.predicate = NSPredicate(format: "id = %@", id.uuidString)
//
//        let context = container.viewContext
//        let entity =  try context.fetch(req)[0]
//        return entity
//    }
//
//    private func saveContext() {
//        let context = container.viewContext
//        if context.hasChanges {
//            do {
//                try context.save()
//            } catch {
//                fatalError("Error: \(error.localizedDescription)")
//            }
//        }
//    }
//
//    init() {
//        container = NSPersistentContainer(name: "Model")
//        container.loadPersistentStores { description, error in
//            if error != nil {
//                fatalError("Cannot Load Core Data Model")
//            }
//        }
//    }
//
//    func findAll() async throws -> [FamilyModel] {
//        let request = Family.fetchRequest()
//        return try container.viewContext.fetch(request).map({ data in
//            FamilyModel(
//                id: data.id!,
//                name: data.name!,
//                uniqueId: data.uniqueId!,
//                createdBy: data.createdBy ?? ""
//            )
//        })
//    }
//
//    func create(family: FamilyModel) async throws {
//        let familyEntity = Family(context: container.viewContext)
//        familyEntity.id = family.id
//        familyEntity.name = family.name
//        familyEntity.uniqueId = family.uniqueId
//        familyEntity.createdBy = family.createdBy
//        saveContext()
//    }
//
//    func delete(id: UUID) async throws {
//        let familyEntity = try getEntityById(id)!
//        let context = container.viewContext
//        context.delete(familyEntity)
//        do {
//            try context.save()
//        } catch {
//            context.rollback()
//            fatalError("Error: \(error.localizedDescription)")
//        }
//    }
//
//    func update(id: UUID, family: FamilyModel) async throws {
//
//    }
//}
