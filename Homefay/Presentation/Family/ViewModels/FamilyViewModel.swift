//
//  File.swift
//  Homefay
//
//  Created by bernardus kanayari on 27/07/23.
//

import Foundation

class FamilyMember: ObservableObject {
    @Published var family: FamilyModel = FamilyModel(
        name: "",
        uniqueId: generateRandomString(length: 6, includeLoweCase: false),
        createdBy: UserModel(
            name: "",
            appleId: "",
            email: ""
        )
    )
    
    
    
}
