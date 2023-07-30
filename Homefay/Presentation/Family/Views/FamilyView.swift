//
//  SwiftUIView.swift
//  Homefay
//
//  Created by bernardus kanayari on 27/07/23.
//

import SwiftUI

struct FamilyView: View {
    
    @State private var searchText = ""
    @StateObject private var vm = FamilyViewModel()
    @State private var isLoading = false
    
    @AppStorage("userFamilyName") var userFamilyName: String = ""
    @AppStorage("userId") var userId: String = ""
    
    var body: some View {
        NavigationStack {
            ZStack {
                List {
                    ForEach(vm.families) { fm in
                        NavigationLink {
                            FamilyDetailView(familyMember: fm)
                        } label: {
                            ItemFamily(fm: fm, meFlag: fm.userId == userId)
                        }
                    }
                }
                .scrollContentBackground(.hidden)
                .background(Color("surfaceColor"))
                .cornerRadius(10)
                .navigationTitle("\(userFamilyName) Family")
                .padding()
                .toolbar {
                    //                //MARK: Edit Button
                    //                ToolbarItem(placement: .navigationBarTrailing) {
                    //                    Button {
                    //                        //Button
                    //                    } label: {
                    //                        Image(systemName: "pencil")
                    //                    }
                    //                }
                    //
                    //                //MARK: Delete Button
                    //                ToolbarItem(placement: .navigationBarTrailing) {
                    //                    Button {
                    //                        //Button
                    //                    } label: {
                    //                        Image(systemName: "trash.fill")
                    //                    }
                    //                }
                    
                    //MARK: Share link Button
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            
                        } label: {
                            Image(systemName: "link")
                        }
                    }
                }
                .padding(.horizontal,0)
                if isLoading {
                    LoadingView()
                }
            }
        }
        .onAppear {
            Task {
                isLoading.toggle()
                await vm.findAll()
                isLoading.toggle()
            }
        }
        .searchable(text: $searchText)
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

struct ItemFamily: View {
    var fm: ProfileModel
    var meFlag: Bool
    
    @State private var img: String = ""
    
    var body: some View {
        HStack {
            Image(img)
                .resizable()
                .scaledToFit()
                .frame(width: 67)
            VStack(alignment: .leading) {
                Text("\(fm.name ?? "")\(meFlag ? " (Me)" : "")")
                    .font(.title3)
                    .fontWeight(.bold)
                ScrollView(.horizontal) {
                    HStack {
                        if let interest = fm.interest {
                            ForEach(interest, id: \.self) { i in
                                Image(i)
                                    .resizable()
                                    .frame(width: 20, height: 20)
                            }
                        }
                    }
                }
                .cornerRadius(16)
                .scrollIndicators(.hidden)
            }
            Spacer()
            VStack {
                Text(fm.dnd ? "Busy" : "Available")
                    .padding(.vertical)
                    .foregroundColor(fm.dnd ? .gray : Color("mainColor"))
                    .font(.caption2)
                Spacer()
            }
        }
        .onAppear {
            if fm.avatar == "" {
                img = "Dad"
            } else {
                img = fm.avatar ?? "Dad"
            }
        }
    }
}

struct FamilyView_Previews: PreviewProvider {
    static var previews: some View {
        FamilyView()
    }
}
