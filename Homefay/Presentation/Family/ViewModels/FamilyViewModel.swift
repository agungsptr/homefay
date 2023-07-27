//
//  File.swift
//  Homefay
//
//  Created by bernardus kanayari on 27/07/23.
//

import Foundation

@MainActor
class FamilyViewModel: ObservableObject {
    @Published var families: [FamilyMemberModel] = []
    
    private lazy var dbFamilyMember = FamilyMemberInjec().useCase()
    
    func findAll() async {
        let res = await self.dbFamilyMember.findAll()
        switch res {
        case .success(let data):
            self.families = data
        case .failure(let error):
            print(error)
        }
    }
}
