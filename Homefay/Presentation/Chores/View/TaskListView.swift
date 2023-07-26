//
//  TaskListView.swift
//  Homefay
//
//  Created by Agung Saputra on 25/07/23.
//

import SwiftUI

struct TaskListView: View {
    @Binding var isAdd: Bool
    
    @State private var selected: FamilyMemberModel?
    @State private var isLoading = false
    
    @StateObject private var vm = TaskListViewModel()
    
    var body: some View {
        ZStack {
            VStack {
                List {
                    ForEach(vm.taskLists) { tl in
                        Section {
                            ChoreItemView()
                        } header: {
                            HStack {
                                Text("\(tl.name)")
                                    .textCase(.none)
                                    .font(.headline)
                                    .fontWeight(.semibold)
                                    .foregroundColor(Color.black)
                            }
                        }
                    }
                }
                .listStyle(.sidebar)
                .cornerRadius(10)
            }
            .onAppear {
                Task {
                    isLoading.toggle()
                    await vm.findAll()
                    isLoading.toggle()
                }
            }
            .sheet(isPresented: $isAdd) {
                NavigationStack {
                    VStack {
                        Form {
                            TextField("Tasklist Name", text: $vm.taskList.name)
                            HStack(alignment: .center, spacing: 0) {
                                VStack {
                                    Text("Assignee")
                                        .foregroundColor(.black)
                                        .frame(width: 167, height: 20, alignment: .leading)
                                    Text("Select one or more assignee")
                                        .font(.caption)
                                        .foregroundColor(Color(red: 0.24, green: 0.24, blue: 0.26).opacity(0.6))
                                        .frame(width: 167, height: 14, alignment: .topLeading)
                                }
                                Spacer()
                                Text(selected?.name ?? "")
                                    .foregroundColor(.gray)
                            }
                            .padding(.horizontal, 24)
                            .frame(width: 358, height: 44, alignment: .leading)
                            .background(.white)
                            Rectangle()
                                .foregroundColor(.clear)
                                .frame(width: 358, height: 97)
                                .background(.white)
                                .overlay {
                                    ScrollView(.horizontal) {
                                        HStack(spacing: 18) {
                                            ForEach(vm.familyMembers, id: \.self.id) { fm in
                                                Button {
                                                    selected = fm
                                                } label: {
                                                    Badge(
                                                        imgName: fm.role,
                                                        name: fm.name,
                                                        selected: fm.userId == selected?.userId
                                                    )
                                                }
                                            }
                                        }
                                        .padding(.horizontal, 24)
                                    }
                                }
                        }
                        .padding(.top, 16)
                        .ignoresSafeArea(.all)
                        Spacer()
                        Button {
                            Task {
                                vm.taskList.asigneeId = selected?.userId ?? ""
                                vm.taskList.asigneeName = selected?.name ?? ""
                                isLoading.toggle()
                                await vm.createTaskList()
                                isLoading.toggle()
                                isAdd.toggle()
                            }
                        } label: {
                            Rectangle()
                                .foregroundColor(.clear)
                                .frame(width: 358, height: 50)
                                .background(Color(red: 0.03, green: 0.27, blue: 0.58))
                                .cornerRadius(10)
                                .overlay {
                                    Text("Add")
                                        .foregroundColor(.white)
                                }
                        }
                        
                    }
                    .navigationTitle("Add Tasklist")
                    .navigationBarTitleDisplayMode(.inline)
                }
                .onAppear {
                    Task {
                        isLoading.toggle()
                        await vm.findAllFamilyMember()
                        isLoading.toggle()
                    }
                }
            }
            if isLoading {
                LoadingView()
            }
        }
    }
}

private struct Badge: View {
    var imgName: String
    var name: String
    var selected: Bool
    
    @State private var imgAsset = ""
    
    var body: some View {
        VStack {
            Rectangle()
                .foregroundColor(.clear)
                .frame(width: 50, height: 50)
                .background(
                    Image(imgAsset)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 50, height: 50)
                        .clipped()
                )
                .cornerRadius(50)
                .overlay {
                    if selected {
                        Text(Image(systemName: "checkmark"))
                            .fontWeight(.bold)
                            .foregroundColor(Color(red: 0.03, green: 0.27, blue: 0.58))
                    }
                }
            Text(name)
                .font(.caption)
                .foregroundColor(.gray)
        }
        .onAppear {
            switch imgName {
            case "Dad":
                imgAsset = "Father"
            case "Mom":
                imgAsset = "Mother"
            case "Boy":
                imgAsset = "Boy"
            case "Girl":
                imgAsset = "Girl"
            default:
                break
            }
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

private struct ChoreItemView: View {
    var body: some View {
        HStack {
            Image("paws")
            VStack(alignment: .leading) {
                Text("Cleaning Oyen Cage")
                Text("08.00")
                    .font(.caption)
                Text("Medium")
                    .font(.caption)
                    .foregroundColor(Color("mediumTask"))
            }
            Spacer()
            VStack {
                Spacer()
                Image("girlAvatar")
            }
        }
    }
}

struct TaskListView_Previews: PreviewProvider {
    static var previews: some View {
        ChoresView()
    }
}
