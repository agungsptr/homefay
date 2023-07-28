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
    
    var body: some View {
        NavigationStack {
            ZStack {
                List {
                    ForEach(vm.families) { fm in
                        ItemFamily(name: fm.name, img: fm.role)
                    }
                }
                .scrollContentBackground(.hidden)
                .background(Color("surfaceColor"))
                .cornerRadius(10)
                .navigationTitle("Keluarga Haji Agung")
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
                            //
                        } label: {
                            Image(systemName: "link")
                        }
                    }
                }
                .padding(.horizontal,0)
            }
            if isLoading {
                LoadingView()
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
    var name: String
    var img: String?
    
    var body: some View {
        HStack {
            Image(img ?? "profil")
                .resizable()
                .scaledToFit()
                .frame(width: 67)
            VStack(alignment: .leading) {
                Text(name)
                    .font(.title2)
                    .fontWeight(.bold)
                HStack {
                    Image("Garden")
                        .resizable()
                        .frame(width: 20, height: 20)
                    Image("Shopping")
                        .resizable()
                        .frame(width: 20, height: 20)
                    Image("PetCare")
                        .resizable()
                        .frame(width: 20, height: 20)
                    Image("Kitchen").resizable()
                        .frame(width: 20, height: 20)
                    Image("HouseCleaning").resizable()
                        .frame(width: 20, height: 20)
                }
            }
            
            Spacer()
            
            VStack {
                Text("available")
                    .padding(.vertical)
                    .foregroundColor(Color("mainColor"))
                Spacer()
            }
        }
    }
}

struct FamilyView_Previews: PreviewProvider {
    static var previews: some View {
        FamilyView()
    }
}
