//
//  File.swift
//  Homefay
//
//  Created by bernardus kanayari on 27/07/23.
//

import Foundation
import SwiftUI

@MainActor
class FamilyViewModel: ObservableObject {
    @Published var families: [ProfileModel] = []
    @AppStorage("userFamilyId") var userFamilyId: String = ""
    
    private lazy var db = ProfileInjec().useCase()
    
    func findAll() async {
        let res = await self.db.findAll(familyId: UUID(uuidString: userFamilyId)!)
        switch res {
        case .success(let data):
            self.families = data
        case .failure(let error):
            print(error)
        }
    }
}
