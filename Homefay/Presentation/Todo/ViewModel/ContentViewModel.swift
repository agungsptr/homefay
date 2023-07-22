//
//  ContentViewModel.swift
//  CleanSwift
//
//  Created by Agung Saputra on 16/07/23.
//

import Foundation

@MainActor
class ContentViewModel: ObservableObject {
    @Published var families: [FamilyModel] = []
    @Published var family = FamilyModel(
        id: .init(),
        name: "",
        uniqueId: generateRandomString(length: 6, includeLoweCase: false),
        createdBy: ""
    )
    
    private lazy var db: FamilyUseCase = FamilyInjec().useCase()

    func findAll() async {
        print("fetch data")
        let res = await self.db.findAll()
        switch res {
        case .success(let data):
            self.families = data
        case .failure(let error):
            print(error)
        }
    }
    
    func save() async {
        let dataModel = family
        let res = await self.db.create(family: dataModel)
        switch res {
        case .success(_):
            await self.findAll()
            self.family = FamilyModel(
                id: .init(),
                name: "",
                uniqueId: generateRandomString(length: 6, includeLoweCase: false),
                createdBy: ""
            )
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
}
