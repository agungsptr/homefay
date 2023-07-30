//
//  ProfileEditView.swift
//  Homefay
//
//  Created by Agung Saputra on 29/07/23.
//

import SwiftUI

struct ProfileEditView: View {
    var profile: ProfileModel
    @Binding var isShowing : Bool
    
    @StateObject private var vm = ProfileViewModel()
    @State private var interest = true
    @State private var preference = true
    @State private var availibility = true
    
    @State private var availSunStart = Date()
    @State private var availSunEnd = Date()
    @State private var availMonStart = Date()
    @State private var availMonEnd = Date()
    @State private var availTueStart = Date()
    @State private var availTueEnd = Date()
    @State private var availWedStart = Date()
    @State private var availWedEnd = Date()
    @State private var availThuStart = Date()
    @State private var availThuEnd = Date()
    @State private var availFriStart = Date()
    @State private var availFriEnd = Date()
    @State private var availSatStart = Date()
    @State private var availSatEnd = Date()
    @State private var avatar = "Dad"
    
    @State private var selectedInterest: [Int] = []
    @State private var selectedPreference: [Int] = []
    
    private let interestList = ["House Cleaning","Wash Clothes","Tidy Up The Bed","Cooking Food","Cleaning The Kitchen","Caring For Plants","Parenting","Caring For Pets","Shop The Needs","Financial Management"]
    
    @AppStorage("userId") var userId: String = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    HStack{
                        Image(avatar)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .clipShape(Circle())
                            .frame(width: 130)
                        VStack {
                            HStack {
                                ForEach(["Dad", "Mom", "Boy1"], id: \.self) { img in
                                    Button {
                                        vm.profile.avatar = img
                                        avatar = img
                                    } label: {
                                        Image(img)
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .clipShape(Circle())
                                            .frame(width: 60)
                                            .overlay {
                                                if vm.profile.avatar == img {
                                                    Circle()
                                                        .fill(Color.gray.opacity(0.3))
                                                        .frame(width: 60, height: 60)
                                                    Text(Image(systemName: "checkmark"))
                                                        .fontWeight(.bold)
                                                        .foregroundColor(Color(red: 0.03, green: 0.27, blue: 0.58))
                                                }
                                            }
                                    }
                                    .buttonStyle(.plain)
                                }
                            }
                            HStack {
                                ForEach(["Boy2", "Girl1", "Girl2"], id: \.self) { img in
                                    Button {
                                        vm.profile.avatar = img
                                        avatar = img
                                    } label: {
                                        Image(img)
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .clipShape(Circle())
                                            .frame(width: 60)
                                            .overlay {
                                                if vm.profile.avatar == img {
                                                    Circle()
                                                        .fill(Color.gray.opacity(0.3))
                                                        .frame(width: 60, height: 60)
                                                    Text(Image(systemName: "checkmark"))
                                                        .fontWeight(.bold)
                                                        .foregroundColor(Color(red: 0.03, green: 0.27, blue: 0.58))
                                                }
                                            }
                                    }
                                    .buttonStyle(.plain)
                                }
                            }
                        }
                    }.padding()
                    
                    Section {
                        TextField(
                            "Your Name Here",
                            text: .init(
                                get: {
                                    return vm.profile.name ?? ""
                                },
                                set: { value in
                                    return vm.profile.name = value
                                }
                            )
                        )
                    } header: {
                        Text("Name")
                    } .headerProminence(.increased)
                    
                    Section {
                        VStack{
                            HStack{
                                Text("Select Your Preferences for Chores")
                                    .fontWeight(.thin)
                                Spacer()
                                Image(systemName: interest ? "chevron.up" : "chevron.down")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 12)
                            }
                            .onTapGesture {
                                self.interest.toggle()
                            }
                            if interest {
                                VStack(spacing: 12) {
                                    HStack(spacing: 24) {
                                        ForEach(0..<5) { i in
                                            Button {
                                                if selectedInterest.contains(i) {
                                                    selectedInterest.removeAll(where: { $0 == i })
                                                } else {
                                                    selectedInterest.append(i)
                                                }
                                            } label: {
                                                Image(interestList[i])
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fit)
                                                    .clipShape(Circle())
                                                    .frame(width: 42)
                                                    .overlay {
                                                        if selectedInterest.contains(i) {
                                                            ZStack {
                                                                Circle()
                                                                    .fill(Color.gray.opacity(0.3))
                                                                    .frame(width: 42, height: 42)
                                                                Text(Image(systemName: "checkmark"))
                                                                    .fontWeight(.bold)
                                                                    .foregroundColor(Color(red: 0.03, green: 0.27, blue: 0.58))
                                                            }
                                                        }
                                                    }
                                            }
                                            .buttonStyle(.plain)
                                        }
                                    }
                                    HStack(spacing: 24) {
                                        ForEach(5..<10) { i in
                                            Button {
                                                if selectedInterest.contains(i) {
                                                    selectedInterest.removeAll(where: { $0 == i })
                                                } else {
                                                    selectedInterest.append(i)
                                                }
                                            } label: {
                                                Image(interestList[i])
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fit)
                                                    .clipShape(Circle())
                                                    .frame(width: 42)
                                                    .overlay {
                                                        if selectedInterest.contains(i) {
                                                            ZStack {
                                                                Circle()
                                                                    .fill(Color.gray.opacity(0.3))
                                                                    .frame(width: 42, height: 42)
                                                                Text(Image(systemName: "checkmark"))
                                                                    .fontWeight(.bold)
                                                                    .foregroundColor(Color(red: 0.03, green: 0.27, blue: 0.58))
                                                            }
                                                        }
                                                    }
                                            }
                                            .buttonStyle(.plain)
                                        }
                                    }
                                }
                            }
                        }
                    } header: {
                        Text("Preference")
                    }
                    .headerProminence(.increased)
                    
                    Section {
                        VStack{
                            HStack{
                                Text("Set Your Availibility Time for Chores")
                                    .fontWeight(.thin)
                                Spacer()
                                Image(systemName: availibility ? "chevron.up" : "chevron.down")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 12)
                            }.onTapGesture {
                                self.availibility.toggle()
                            }
                            if availibility {
                                VStack(spacing: 12) {
                                    AvailPicker(day: "Sunday",start: $availSunStart, end: $availSunEnd)
                                    AvailPicker(day: "Monday",start: $availMonStart, end: $availMonEnd)
                                    AvailPicker(day: "Tuesday",start: $availTueStart, end: $availTueEnd)
                                    AvailPicker(day: "Wednesday",start: $availWedStart, end: $availWedEnd)
                                    AvailPicker(day: "Thursday",start: $availThuStart, end: $availThuEnd)
                                    AvailPicker(day: "Friday",start: $availFriStart, end: $availFriEnd)
                                    AvailPicker(day: "Saturday",start: $availSatStart, end: $availSatEnd)
                                }
                            }
                        }
                    } header: {
                        Text("Availibility")
                    }
                    
                }
                .padding(.top, -32) 
                
                HStack(alignment: .center, spacing: 10) {
                    Button {
                        Task {
                            let dataInterest = selectedInterest.map { e in
                                interestList[e]
                            }
                            vm.profile.interest = dataInterest
                            vm.profile.availSun = [availSunStart, availSunEnd]
                            vm.profile.availMon = [availMonStart, availMonEnd]
                            vm.profile.availTue = [availTueStart, availTueEnd]
                            vm.profile.availWed = [availWedStart, availWedEnd]
                            vm.profile.availThu = [availThuStart, availThuEnd]
                            vm.profile.availFri = [availFriStart, availFriEnd]
                            vm.profile.availSat = [availSatStart, availSatEnd]
                            await vm.update(id: vm.profile.id!)
                            await vm.find(userId: UUID(uuidString: vm.profile.userId)!)
                            isShowing = false
                        }
                    } label: {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color("PrimaryColor"))
                            .frame(width: 358, height: 50, alignment: .center)
                            .overlay(
                                Text("Save")
                                    .foregroundColor(.white)
                            )
                    }

                }
            }
            .navigationTitle("Edit Profile")
            .navigationBarTitleDisplayMode(.inline)
        }
        .onAppear {
            if let img = vm.profile.avatar {
                avatar = img
            }
            vm.profile = profile
        }
    }
}

private struct AvailPicker: View {
    var day: String
    @Binding var start: Date
    @Binding var end: Date
    
    var body: some View {
        HStack {
            Text(day)
            Spacer()
            Text(start.formatted(date: .omitted, time: .shortened))
                .font(.callout)
                .foregroundColor(.gray)
                .overlay {
                    DatePicker(
                        selection: $start,
                        displayedComponents: [.hourAndMinute]
                    ) {
                        
                    }
                    .labelsHidden()
                    .blendMode(.destinationOver)
                }
            Text("-")
            Text(end.formatted(date: .omitted, time: .shortened))
                .font(.callout)
                .foregroundColor(.gray)
                .overlay {
                    DatePicker(
                        selection: $end,
                        displayedComponents: [.hourAndMinute]
                    ) {
                        
                    }
                    .labelsHidden()
                    .blendMode(.destinationOver)
                }
        }
    }
}

//struct ProfileEditView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileEditView(isShowing: .constant(true))
//    }
//}

