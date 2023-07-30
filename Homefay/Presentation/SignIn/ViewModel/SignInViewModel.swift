//
//  SignInViewModel.swift
//  Homefay
//
//  Created by Agung Saputra on 25/07/23.
//

import Foundation
import SwiftUI

@MainActor
class SignInViewModel: ObservableObject {
    @Published var user = UserModel(
        name: "", appleId: "", email: ""
    )
    
    private lazy var db: UserUseCase = UserInjec().useCase()
    
    // User credential
    @AppStorage("userId") var userId: String = "" // this value get by cloudkit not by auth apple
    @AppStorage("userName") var userName: String = ""
    @AppStorage("userAppleId") var userAppleId: String = ""
    @AppStorage("userEmail") var userEmail: String = ""
    
    // Family Info
    @AppStorage("userFamilyId") var userFamilyId: String = ""
    
    func create() async {
        let res = await self.db.create(user: user)
        switch res {
        case .success(let data):
            self.user.id = data.id
            self.user.name = data.name
            self.user.appleId = data.appleId
            self.user.email = data.email
            
            userId = data.id!.uuidString
            userName = data.name ?? ""
            userAppleId = data.appleId
            userEmail = data.email ?? ""
        case .failure(let error):
            print(error)
        }
    }
}
