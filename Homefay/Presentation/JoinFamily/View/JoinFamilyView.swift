//
//  JoinFamilyView.swift
//  Homefay
//
//  Created by Agung Saputra on 24/07/23.
//

import SwiftUI

struct JoinFamilyView: View {
    @StateObject private var vm = CreateFamilyViewModel()
    
    @State private var isShowAlertCreate = false
    @State private var isShowAlertJoin = false
    @State private var isShowAlertFamilyCode = false
    @State private var isLoading = false
    @State private var navigation = false
    @State private var familyCode = ""
    
    // User credential
    @AppStorage("userId") var userId: String = "" // this value get by cloudkit not by auth apple
    @AppStorage("userName") var userName: String = ""
    @AppStorage("userAppleId") var userAppleId: String = ""
    @AppStorage("userEmail") var userEmail: String = ""
    
    // Family Info
    @AppStorage("userFamilyId") var userFamilyId: String = ""
    @AppStorage("userFamilyName") var userFamilyName: String = ""
    
    var body: some View {
        ZStack {
            ZStack {
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: 358, height: 211)
                    .background(Color(red: 0.79, green: 0.91, blue: 0.98))
                    .cornerRadius(10)
                VStack {
                    // Button create family
                    Button {
                        isShowAlertCreate.toggle()
                    } label: {
                        CustomButton(
                            iconName: "figure.2.and.child.holdinghands",
                            label: "Create Family"
                        )
                    }
                    .alert("Create Family", isPresented: $isShowAlertCreate) {
                        TextField("Family Name", text: $vm.family.name)
                        Button {
                            isShowAlertCreate.toggle()
                        } label: {
                            Text("Cancel")
                        }
                        Button {
                            Task {
                                isLoading.toggle()
                                await vm.create()
                                userFamilyName = vm.family.name
                                isLoading.toggle()
                                isShowAlertFamilyCode.toggle()
                            }
                        } label: {
                            Text("Create")
                                .fontWeight(.bold)
                        }
                    } message: {
                        Text("Please input the name for the family you want to create.")
                    }
                    .alert("Get your family invitation code!", isPresented: $isShowAlertFamilyCode) {
                        Button {
                            userFamilyId = vm.family.id?.uuidString ?? ""
                        } label: {
                            Text("Done")
                                .fontWeight(.bold)
                        }
                    } message: {
                        Text("\(vm.family.uniqueId)")
                    }
                    
                    // Button join family
                    Button {
                        isShowAlertJoin.toggle()
                    } label: {
                        CustomButton(
                            iconName: "figure.stand.line.dotted.figure.stand",
                            label: "Join Family"
                        )
                    }
                    .alert("Join Family", isPresented: $isShowAlertJoin) {
                        TextField("Family Code", text: $familyCode)
                        Button {
                            isShowAlertJoin.toggle()
                        } label: {
                            Text("Cancel")
                        }
                        Button {
                            Task {
                                isLoading.toggle()
                                await vm.join(familyCode: familyCode)
                                isLoading.toggle()
                                isShowAlertJoin.toggle()
                            }
                        } label: {
                            Text("Join")
                                .fontWeight(.bold)
                        }
                    } message: {
                        Text("Enter the specified family link to access.")
                    }
                }
            }
            if isLoading {
                LoadingView()
            }
        }
        .onAppear {
            vm.family.createdBy.id = UUID(uuidString: userId)
            vm.family.createdBy.name = userName
            vm.family.createdBy.appleId = userAppleId
            vm.family.createdBy.email = userEmail
        }
    }
}

private struct CustomButton: View {
    let iconName: String
    let label: String
    
    var body: some View {
        Rectangle()
            .foregroundColor(.clear)
            .frame(width: 336, height: 89)
            .background(.white)
            .cornerRadius(10)
            .overlay {
                HStack(alignment: .center, spacing: 4) {
                    Image(systemName: iconName)
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color(red: 0.03, green: 0.27, blue: 0.58))
                    Text(label)
                        .font(Font.custom("SF Pro", size: 17))
                        .foregroundColor(Color(red: 0.03, green: 0.27, blue: 0.58))
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 14)
                .cornerRadius(12)
            }
    }
}

private struct LoadingView: View {
    var body: some View {
        ZStack {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .black))
        }
    }
}

struct JoinFamilyView_Previews: PreviewProvider {
    static var previews: some View {
        JoinFamilyView()
    }
}
