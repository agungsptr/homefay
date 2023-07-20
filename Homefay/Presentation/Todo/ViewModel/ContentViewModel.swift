//
//  ContentViewModel.swift
//  CleanSwift
//
//  Created by Agung Saputra on 16/07/23.
//

import Foundation

@MainActor
class ContentViewModel: ObservableObject {
    @Published var families = [FamilyModel]()
    @Published var family = FamilyModel(
        id: .init(),
        name: "",
        uniqueId: generateRandomString(length: 6, includeLoweCase: false)
    )
    
    private let db: FamilyUseCase
    
    init() {
        self.db = FamilyInjec().useCase()
        findAll()
    }
    
    func findAll() {
        let res = self.db.findAll()
        switch res {
        case .success(let data):
            self.families = data
        case .failure(let error):
            print(error)
        }
    }
    
    func save() {
        let dataModel = family
        let res = self.db.create(family: dataModel)
        switch res {
        case .success(_):
            self.findAll()
            self.family = FamilyModel(
                id: .init(),
                name: "",
                uniqueId: generateRandomString(length: 6, includeLoweCase: false)
            )
        case .failure(let error):
            print(error)
        }
    }
}
