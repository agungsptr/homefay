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
        dnd: false, userId: "", familyId: "", name: ""
    )
    
    private lazy var dbProfile = ProfileInjec().useCase()
    
    @AppStorage("userName") var userName: String = ""
    
    func find(userId: UUID) async {
        let res = await self.dbProfile.find(userId: userId)
        switch res {
        case .success(var data):
            if data.avatar == "" {
                data.avatar = "Dad"
            }
            self.profile = data
        case .failure(let error):
            print(error)
        }
    }
    
    
    func update(id: UUID) async {
        let res = await self.dbProfile.update(
            id: id,
            profile: profile
        )
        switch res {
        case .success(_):
            userName = profile.name ?? ""
        case .failure(let error):
            print(error)
        }
    }
}
