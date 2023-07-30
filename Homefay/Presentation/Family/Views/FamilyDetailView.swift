//
//  FamilyDetailView.swift
//  Homefay
//
//  Created by Agung Saputra on 27/07/23.
//

import SwiftUI

struct FamilyDetailView: View {
    var familyMember: ProfileModel
    
    @AppStorage("userName") var userName: String = ""
    @AppStorage("userId") var userId: String = ""
    @AppStorage("userAppleId") var userAppleId: String = ""
    @AppStorage("userEmail") var userEmail: String = ""
    
    @State private var sheet = false
    @State private var isLoading = false
    @State private var isOn = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    Image(familyMember.avatar ?? "Dad")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .clipShape(Circle())
                        .frame(width: 130)
                        .overlay(
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
                        )
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
                                    AvailText(time: familyMember.availSun)
                                        .foregroundColor(.gray)
                                }
                                HStack{
                                    Text("Monday")
                                    Spacer()
                                    AvailText(time: familyMember.availMon)
                                        .foregroundColor(.gray)
                                }
                                HStack{
                                    Text("Tuesday")
                                    Spacer()
                                    AvailText(time: familyMember.availTue)
                                        .foregroundColor(.gray)
                                }
                                HStack{
                                    Text("Wednesday")
                                    Spacer()
                                    AvailText(time: familyMember.availWed)
                                        .foregroundColor(.gray)
                                }
                                HStack{
                                    Text("Thursday")
                                    Spacer()
                                    AvailText(time: familyMember.availThu)
                                        .foregroundColor(.gray)
                                }
                                HStack{
                                    Text("Friday")
                                    Spacer()
                                    AvailText(time: familyMember.availFri)
                                        .foregroundColor(.gray)
                                }
                                HStack{
                                    Text("Saturday")
                                    Spacer()
                                    AvailText(time: familyMember.availSat)
                                        .foregroundColor(.gray)
                                }
                                Toggle ("Do Not Distrub", isOn: $isOn)
                                    .toggleStyle(SwitchToggleStyle(tint: .blue))
                            }
                        } header: {
                            Text("Availibility")
                        } .headerProminence(.increased)
                    }
                    .navigationTitle("Profile")
                }
                .padding(.top, 16)
                if isLoading {
                    LoadingView()
                }
            }
            .onAppear {
                isOn = familyMember.dnd
            }
        }
    }
    
    func imageView(at index: Int, imageName: String, width: CGFloat, height: CGFloat, x: CGFloat, y: CGFloat) -> some View {
        if let interest = familyMember.interest, interest.indices.contains(index) {
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
}

private struct AvailText: View {
    var time: [Date]?
    
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

//struct FamilyDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        FamilyDetailView()
//    }
//}
