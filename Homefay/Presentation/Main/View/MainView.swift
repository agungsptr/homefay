//
//  ContentView.swift
//  Homefay
//
//  Created by Agung Saputra on 24/07/23.
//

import SwiftUI

struct MainView: View {
    
    // User credential
    @AppStorage("userId") var userId: String = "" // this value get by cloudkit not by auth apple
    @AppStorage("userName") var userName: String = ""
    @AppStorage("userAppleId") var userAppleId: String = ""
    @AppStorage("userEmail") var userEmail: String = ""
    
    // Family Info
    @AppStorage("userFamilyId") var userFamilyId: String = ""
    
    var body: some View {
        TabView {
            ChoresView()
                .tabItem {
                    Label("Chores", systemImage: "square.grid.2x2.fill")
                }
            FamilyView()
                .tabItem {
                    Label("Family", systemImage: "person.2.fill")
                }
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.fill")
                }
        }
    }
}


struct SampleTabView: View {
    var body: some View {
        Text("Tab2")
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
