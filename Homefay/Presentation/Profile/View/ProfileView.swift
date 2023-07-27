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
    @AppStorage("userEmail") var userEmail: String = ""
    
    var body: some View {
        NavigationStack{
            VStack {
                Image("Dad")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(Circle())
                    .frame(width: 130)
                    .overlay(
                        GeometryReader { geometry in
                            Image(vm.profile.interest?[0] ?? "Bulat")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .position(x: geometry.size.width * 1.2, y: geometry.size.height * 0.5)
                            Image(vm.profile.interest?[2] ?? "Bulat")
                                .position(x: geometry.size.width * 1.1, y: geometry.size.height * 1.3)
                            Image(vm.profile.interest?[4] ?? "Bulat")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .position(x: geometry.size.width * 1.0, y: geometry.size.height * -0.25)
                            Image(vm.profile.interest?[6] ?? "Bulat")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .position(x: geometry.size.width * 1.55, y: geometry.size.height * -0.15)
                            Image(vm.profile.interest?[8] ?? "Bulat")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .position(x: geometry.size.width * 1.63, y: geometry.size.height * 1.0)
                            
                            Image(vm.profile.interest?[1] ?? "Bulat")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .position(x: geometry.size.width * -0.2, y: geometry.size.height * 0.5)
                            Image(vm.profile.interest?[3] ?? "Bulat")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .position(x: geometry.size.width * -0.1, y: geometry.size.height * 1.3)
                            Image(vm.profile.interest?[5] ?? "Bulat")
                                .position(x: geometry.size.width * -0.05, y: geometry.size.height * -0.3)
                            Image(vm.profile.interest?[7] ?? "Bulat")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .position(x: geometry.size.width * -0.6, y: geometry.size.height * -0.14)
                            Image(vm.profile.interest?[9] ?? "Bulat")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .position(x: geometry.size.width * -0.65, y: geometry.size.height * 0.99)
                        }.padding()
                    )
                    .padding()
                
                Text("\(userName)")
                    .padding(.top, 16)
                
                Form{
                    Section{
                        TextField("Email", text: $userEmail)
                            
                    } header: {
                        Text("Apple ID")
                    } .headerProminence(.increased)
                    
                    
                    Section{
                        List{
                            HStack{
                                Text("Sunday")
                                Spacer()
                                AvailText(time: vm.profile.availSun)
                                    .foregroundColor(.gray)
                            }
                            HStack{
                                Text("Monday")
                                Spacer()
                                AvailText(time: vm.profile.availMon)
                                    .foregroundColor(.gray)
                            }
                            HStack{
                                Text("Tuesday")
                                Spacer()
                                AvailText(time: vm.profile.availTue)
                                    .foregroundColor(.gray)
                            }
                            HStack{
                                Text("Wednesday")
                                Spacer()
                                AvailText(time: vm.profile.availWed)
                                    .foregroundColor(.gray)
                            }
                            HStack{
                                Text("Thursday")
                                Spacer()
                                AvailText(time: vm.profile.availThu)
                                    .foregroundColor(.gray)
                            }
                            HStack{
                                Text("Friday")
                                Spacer()
                                AvailText(time: vm.profile.availFri)
                                    .foregroundColor(.gray)
                            }
                            HStack{
                                Text("Saturday")
                                Spacer()
                                AvailText(time: vm.profile.availSat)
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
                        
                    } label: {
                        Text("Edit")
                    }

//                    Button (action: {showModel = true}) {
//                        Text("Edit")
//                    }
//                    EditProfile(isShowing: $showModel)
                }
            }
        }
        
    }
}

struct AvailText: View {
    var time: [Date]?
    
    @State private var start = ""
    @State private var end = ""
    
    var body: some View {
        Text("\(start) - \(end)")
            .onAppear {
                if time?.count == 2 {
                    start = time![0]
                        .formatted(date: .omitted, time: .shortened)
                    end = time![1]
                        .formatted(date: .omitted, time: .shortened)
                }
            }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
