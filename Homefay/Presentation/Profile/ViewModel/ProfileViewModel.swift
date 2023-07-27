//
//  ProfileViewMode.swift
//  Homefay
//
//  Created by Agung Saputra on 27/07/23.
//

import Foundation
import SwiftUI

@MainActor
class ProfileViewModel: ObservableObject {
    @Published var profile = ProfileModel(
        dnd: false, userId: ""
    )
    
    private lazy var dbProfile = ProfileInjec().useCase()
    
    @AppStorage("userId") private var userId: String = ""
    
    func findAll(userId: String) async {
        let res = await self.dbProfile.find(userId: UUID(uuidString: userId)!)
        switch res {
        case .success(let data):
            self.profile = data
        case .failure(let error):
            print(error)
        }
    }
    
    
//    func update(id: UUID) async {
//        let res = await self.db.update(
//            id: id,
//            family: FamilyModel(
//                id: nil,
//                name: "update",
//                uniqueId: "",
//                createdBy: self.family.createdBy
//            )
//        )
//        switch res {
//        case .success(_):
//            await self.findAll()
//        case .failure(let error):
//            print(error)
//        }
//    }
}
