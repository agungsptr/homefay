//
//  JoinFamilyViewModel.swift
//  Homefay
//
//  Created by Agung Saputra on 24/07/23.
//

import Foundation
import SwiftUI

@MainActor
class CreateFamilyViewModel: ObservableObject {
    @Published var families: [FamilyModel] = []
    @Published var family: FamilyModel = FamilyModel(
        name: "",
        uniqueId: generateRandomString(length: 6, includeLoweCase: false),
        createdBy: UserModel(
            name: "",
            appleId: "",
            email: ""
        )
    )
    @Published var familyCode = ""
    @Published var role = ""
    
    @AppStorage("userFamilyId") var userFamilyId: String = ""
    @AppStorage("userFamilyName") var userFamilyName: String = ""
    @AppStorage("userId") var userId: String = ""
    
    private lazy var db: FamilyUseCase = FamilyInjec().useCase()
    private lazy var dbFamilyMember = FamilyMemberInjec().useCase()
    private lazy var dbProfile = ProfileInjec().useCase()
    
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
            
            let _ = await self.dbFamilyMember.create(
                familyMember: FamilyMemberModel(
                    familyId: data.id!.uuidString,
                    name: self.family.createdBy.name,
                    role: self.role,
                    userId: self.family.createdBy.id!.uuidString
                )
            )
            
            let _ = await self.dbProfile.create(
                profile: ProfileModel(
                    availSun: [Date(), Date()],
                    availMon: [Date(), Date()],
                    availTue: [Date(), Date()],
                    availWed: [Date(), Date()],
                    availThu: [Date(), Date()],
                    availFri: [Date(), Date()],
                    availSat: [Date(), Date()],
                    dnd: false,
                    userId: self.family.createdBy.id!.uuidString,
                    familyId: data.id!.uuidString
                )
            )
        case .failure(let error):
            print(error)
        }
    }
    
    func join(familyCode: String) async {
        let res = await self.db.findByCode(familyCode: familyCode)
        switch res {
        case .success(let data):
            self.family = data
            userFamilyId = data.id!.uuidString
            userFamilyName = data.name
            
            let res = await self.dbProfile.create(
                profile: ProfileModel(
                    availSun: [Date(), Date()],
                    availMon: [Date(), Date()],
                    availTue: [Date(), Date()],
                    availWed: [Date(), Date()],
                    availThu: [Date(), Date()],
                    availFri: [Date(), Date()],
                    availSat: [Date(), Date()],
                    dnd: false,
                    userId: userId,
                    familyId: data.id!.uuidString
                )
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
