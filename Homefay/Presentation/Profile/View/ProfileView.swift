//
//  ProfileView.swift
//  Homefay
//
//  Created by Agung Saputra on 27/07/23.
//

import SwiftUI

struct ProfileView: View {
    @StateObject private var vm = ProfileViewModel()
    
    @AppStorage("userName") var userName: String = ""
    @AppStorage("userId") var userId: String = ""
    @AppStorage("userAppleId") var userAppleId: String = ""
    @AppStorage("userEmail") var userEmail: String = ""
    
    @State private var sheet = false
    @State private var isLoading = false
    @State private var avatar = "Dad"
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    ZStack{
                        Image("Dad")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .clipShape(Circle())
                            .frame(width: 130)
                            .overlay(
                                GeometryReader { geometry in
                                    dummyImg(at: 0, imageName: "Bulat", width: 40, height: 40, x: geometry.size.width * 1.2, y: geometry.size.height * 0.5)
                                    dummyImg(at: 4, imageName: "Bulat", width: 50, height: 50, x: geometry.size.width * 1.1, y: geometry.size.height * 1.3)
                                    dummyImg(at: 2, imageName: "Bulat", width: 40, height: 40, x:
                                                geometry.size.width * 1.1, y: geometry.size.height * -0.25)
                                    dummyImg(at: 6, imageName: "Bulat", width: 40, height: 40, x: geometry.size.width * 1.65, y: geometry.size.height * -0.15)
                                    dummyImg(at: 8, imageName: "Bulat", width: 40, height: 40, x: geometry.size.width * 1.63, y: geometry.size.height * 1.0)
                                    
                                    dummyImg(at: 1, imageName: "Bulat", width: 40, height: 40, x: geometry.size.width * -0.2, y: geometry.size.height * 0.5)
                                    dummyImg(at: 3, imageName: "Bulat", width: 50, height: 50, x: geometry.size.width * -0.1, y: geometry.size.height * 1.3)
                                    dummyImg(at: 5, imageName: "Bulat", width: 40, height: 40, x: geometry.size.width * -0.05, y: geometry.size.height * -0.3)
                                    dummyImg(at: 7, imageName: "Bulat", width: 40, height: 40, x: geometry.size.width * -0.6, y: geometry.size.height * -0.14)
                                    dummyImg(at: 9, imageName: "Bulat", width: 40, height: 40, x: geometry.size.width * -0.65, y: geometry.size.height * 0.99)
                                }.padding()
                            )
                            .overlay {
                                GeometryReader { geometry in
                                    imageView(at: 0, imageName: "Bulat", width: 40, height: 40, x: geometry.size.width * 1.2, y: geometry.size.height * 0.5)
                                    imageView(at: 4, imageName: "Bulat", width: 50, height: 50, x: geometry.size.width * 1.1, y: geometry.size.height * 1.3)
                                    imageView(at: 2, imageName: "Bulat", width: 40, height: 40, x:
                                                geometry.size.width * 1.1, y: geometry.size.height * -0.25)
                                    imageView(at: 6, imageName: "Bulat", width: 40, height: 40, x: geometry.size.width * 1.65, y: geometry.size.height * -0.15)
                                    imageView(at: 8, imageName: "Bulat", width: 40, height: 40, x: geometry.size.width * 1.63, y: geometry.size.height * 1.0)
                                    
                                    imageView(at: 1, imageName: "Bulat", width: 40, height: 40, x: geometry.size.width * -0.2, y: geometry.size.height * 0.5)
                                    imageView(at: 3, imageName: "Bulat", width: 50, height: 50, x: geometry.size.width * -0.1, y: geometry.size.height * 1.3)
                                    imageView(at: 5, imageName: "Bulat", width: 40, height: 40, x: geometry.size.width * -0.05, y: geometry.size.height * -0.3)
                                    imageView(at: 7, imageName: "Bulat", width: 40, height: 40, x: geometry.size.width * -0.6, y: geometry.size.height * -0.14)
                                    imageView(at: 9, imageName: "Bulat", width: 40, height: 40, x: geometry.size.width * -0.65, y: geometry.size.height * 0.99)
                                }.padding()
                            }
                        Image(avatar)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .clipShape(Circle())
                            .frame(width: 130)
                    }
                    .padding()
                    
                    Text("\(userName)")
                        .font(.title3)
                        .fontWeight(.bold)
                        .padding(.top, 8)
                    
                    Form {
                        //                        Section{
                        //                            Text(userEmail.isEmpty ? userAppleId : userEmail)
                        //                                .foregroundColor(.gray)
                        //                        } header: {
                        //                            Text("Apple ID")
                        //                        } .headerProminence(.increased)
                        
                        Section{
                            List{
                                HStack{
                                    Text("Sunday")
                                    Spacer()
                                    AvailText(time: $vm.profile.availSun)
                                        .foregroundColor(.gray)
                                }
                                HStack{
                                    Text("Monday")
                                    Spacer()
                                    AvailText(time: $vm.profile.availMon)
                                        .foregroundColor(.gray)
                                }
                                HStack{
                                    Text("Tuesday")
                                    Spacer()
                                    AvailText(time: $vm.profile.availTue)
                                        .foregroundColor(.gray)
                                }
                                HStack{
                                    Text("Wednesday")
                                    Spacer()
                                    AvailText(time: $vm.profile.availWed)
                                        .foregroundColor(.gray)
                                }
                                HStack{
                                    Text("Thursday")
                                    Spacer()
                                    AvailText(time: $vm.profile.availThu)
                                        .foregroundColor(.gray)
                                }
                                HStack{
                                    Text("Friday")
                                    Spacer()
                                    AvailText(time: $vm.profile.availFri)
                                        .foregroundColor(.gray)
                                }
                                HStack{
                                    Text("Saturday")
                                    Spacer()
                                    AvailText(time: $vm.profile.availSat)
                                        .foregroundColor(.gray)
                                }
                                Toggle ("Do Not Distrub", isOn: $vm.profile.dnd)
                                    .toggleStyle(SwitchToggleStyle(tint: .blue))
                            }
                        } header: {
                            Text("Availibility")
                        } .headerProminence(.increased)
                    }
                    .navigationTitle("Profile")
                }
                .padding(.top, 16)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            sheet.toggle()
                        } label: {
                            Text("Edit")
                                .fontWeight(.bold)
                        }
                    }
                }
                .sheet(isPresented: $sheet) {
                    ProfileEditView(profile: vm.profile, isShowing: $sheet)
                }
                .onChange(of: sheet, perform: { _ in
                    Task {
                        isLoading.toggle()
                        await vm.find(userId: UUID(uuidString: userId)!)
                        if let img = vm.profile.avatar {
                            avatar = img
                        }
                        isLoading.toggle()
                        print(avatar)
                    }
                })
                .onAppear {
                    if let img = vm.profile.avatar {
                        avatar = img
                    }
                    Task {
                        isLoading.toggle()
                        await vm.find(userId: UUID(uuidString: userId)!)
                        isLoading.toggle()
                    }
                }
                if isLoading {
                    LoadingView()
                }
            }
            
        }
    }
    
    func imageView(at index: Int, imageName: String, width: CGFloat, height: CGFloat, x: CGFloat, y: CGFloat) -> some View {
        if let interest = vm.profile.interest, interest.indices.contains(index) {
            return Image(interest[index])
                .resizable()
                .frame(width: width, height: height)
                .position(x: x, y: y)
        } else {
            return Image(imageName)
                .resizable()
                .frame(width: width, height: height)
                .position(x: x, y: y)
        }
    }
    
    func dummyImg(at index: Int, imageName: String, width: CGFloat, height: CGFloat, x: CGFloat, y: CGFloat) -> some View {
        return Image(imageName)
            .resizable()
            .frame(width: width, height: height)
            .position(x: x, y: y)
    }
}

private struct AvailText: View {
    @Binding var time: [Date]?
    
    var body: some View {
        if let date = time {
            Text(formatText(date: date))
        } else {
            Text("-")
        }
    }
    
    func formatText(date: [Date]) -> String {
        var text1 = ""
        var text2 = ""
        if date.count == 2 {
            text1 = date[0]
                .formatted(date: .omitted, time: .shortened)
            text2 = date[1]
                .formatted(date: .omitted, time: .shortened)
        }
        return "\(text1) - \(text2)"
    }
}

private struct LoadingView: View {
    var body: some View {
        Color.white
            .ignoresSafeArea(.all)
        ZStack {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .black))
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
