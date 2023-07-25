//
//  RouterView.swift
//  Homefay
//
//  Created by Agung Saputra on 25/07/23.
//

import SwiftUI

struct RouterView: View {
    @AppStorage("userFamilyId") var userFamilyId: String?
    @AppStorage("userId") var userId: String?
    
    var body: some View {
        if userId != nil && userFamilyId != nil {
            MainView()
        } else if userId != nil && userFamilyId == nil  {
            JoinFamilyView()
        } else {
            SignInView()
        }
    }
}

struct RouterView_Previews: PreviewProvider {
    static var previews: some View {
        RouterView()
    }
}
