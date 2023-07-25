//
//  JoinFamilyViewModel.swift
//  Homefay
//
//  Created by Agung Saputra on 24/07/23.
//

import Foundation

@MainActor
class JoinFamilyViewModel: ObservableObject {
    @Published var families: [FamilyModel] = []
    @Published var familyCode = ""
    @Published var family: FamilyModel = FamilyModel(
        id: nil,
        name: "",
        uniqueId: generateRandomString(length: 6, includeLoweCase: false),
        createdBy: UserModel(
            id: nil,
            name: "",
            appleId: "",
            email: ""
        )
    )
    
    private lazy var db: FamilyUseCase = FamilyInjec().useCase()
    
    func findAll() async {
        let res = await self.db.findAll()
        switch res {
        case .success(let data):
            self.families = data
        case .failure(let error):
            print(error)
        }
    }
    
    func create() async {
        let res = await self.db.create(family: family)
        switch res {
        case .success(let data):
            self.family.id = data.id
            self.family.name = data.name
            self.family.uniqueId = data.uniqueId
//            userFamilyId = data.id?.uuidString ?? ""
            await self.findAll()
        case .failure(let error):
            print(error)
        }
    }
    
    func delete(id: UUID) async {
        let res = await self.db.delete(id: id)
        switch res {
        case .success(_):
            await self.findAll()
        case .failure(let error):
            print(error)
        }
    }
    
    func update(id: UUID) async {
        let res = await self.db.update(
            id: id,
            family: FamilyModel(
                id: nil,
                name: "update",
                uniqueId: "",
                createdBy: self.family.createdBy
            )
        )
        switch res {
        case .success(_):
            await self.findAll()
        case .failure(let error):
            print(error)
        }
    }
}
