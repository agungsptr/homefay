//
//  ChoresAddView.swift
//  Homefay
//
//  Created by Agung Saputra on 26/07/23.
//

import SwiftUI

struct ChoresAddView: View {
    @State private var isLoading = false
    @StateObject private var vm = TaskListViewModel()
    
    @State private var sliderValue: Double = 0
    @State private var selected: [FamilyMemberModel] = []
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    Section {
                        TextField("chores", text: $vm.chore.title)
                    } header: {
                        HStack {
                            Text("Chores name")
                                .font(.body)
                                .foregroundColor(Color.black)
                                .textCase(.none)
                                .padding(.top, -10)
                        }
                    }
                    
                    Section {
                        Picker("", selection: $vm.chore.listId) {
                            ForEach(vm.taskLists) { tl in
                                Text(tl.name).tag(tl.id!.uuidString)
                            }
                        }
                        .pickerStyle(.wheel)
                        .frame(maxHeight: 100)
                        
                    } header: {
                        HStack {
                            Text("Task List")
                                .font(.body)
                                .foregroundColor(Color.black)
                                .textCase(.none)
                                .padding(.top, -20)
                        }
                    }
                    
                    Section {
                        Picker("", selection: $vm.chore.category) {
                            Text("House Cleaning").tag("House Cleaning")
                            Text("Wash Clothes").tag("Wash Clothes")
                            Text("Tidy Up The Bed").tag("Tidy Up The Bed")
                            Text("Cooking Food").tag("Cooking Food")
                            Text("Cleaning The Kitchen").tag("Cleaning The Kitchen")
                            Text("Caring For Plants").tag("Caring For Plants")
                            Text("Parenting").tag("Parenting")
                            Text("Caring For Pets").tag("Caring For Pets")
                            Text("Shop The Needs").tag("Shop The Needs")
                            Text("Financial Management").tag("Financial Management")
                        }
                        .pickerStyle(.wheel)
                        .frame(maxHeight: 100)
                        .padding(.top, -20)
                    } header: {
                        HStack {
                            Text("Category")
                                .font(.body)
                                .foregroundColor(Color.black)
                                .textCase(.none)
                                .padding(.top, -20)
                        }
                    }
                    
                    Section {
                        Slider(value: $sliderValue, in: 0...10, step: 5) { _ in
                            if sliderValue <= 0.0 {
                                vm.chore.level = "Low"
                            } else if sliderValue <= 5.0 && sliderValue >= 0.0 {
                                vm.chore.level = "Mid"
                            } else {
                                vm.chore.level = "High"
                            }
                        }
                    } header: {
                        HStack {
                            Text("Difficulty Level")
                                .font(.body)
                                .foregroundColor(Color.black)
                                .textCase(.none)
                                .padding(.top, -20)
                            Spacer()
                            Text("\(vm.chore.level)")
                                .textCase(.none)
                                .font(.body)
                                .padding(.top, -20)
                        }
                    }
                    
                    Section {
                        HStack {
                            Text("Start")
                            Spacer()
                            /** Custom date picker */
                            Text(vm.chore.startTime.formatted(date: .omitted, time: .shortened))
                                .font(.callout)
                                .foregroundColor(.gray)
                                .overlay {
                                    DatePicker(
                                        selection: $vm.chore.startTime,
                                        displayedComponents: [.hourAndMinute]
                                    ) {
                                        
                                    }
                                    .labelsHidden()
                                    .blendMode(.destinationOver)
                                }
                        }
                        HStack {
                            Text("End")
                            Spacer()
                            /** Custom date picker */
                            Text(vm.chore.endTime.formatted(date: .omitted, time: .shortened))
                                .font(.callout)
                                .foregroundColor(.gray)
                                .overlay {
                                    DatePicker(
                                        selection: $vm.chore.endTime,
                                        displayedComponents: [.hourAndMinute]
                                    ) {
                                        
                                    }
                                    .labelsHidden()
                                    .blendMode(.destinationOver)
                                }
                        }
                    } header: {
                        HStack {
                            Text("Schedule")
                                .font(.body)
                                .foregroundColor(Color.black)
                                .textCase(.none)
                                .padding(.top, -20)
                            Spacer()
                            Text("\(vm.chore.startTime.formatted(date: .omitted, time: .shortened)) - \(vm.chore.endTime.formatted(date: .omitted, time: .shortened))")
                                .font(.body)
                                .textCase(.none)
                                .padding(.top, -20)
                        }
                    }
                    
                    Section {
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(height: 100)
                            .overlay {
                                ScrollView(.horizontal) {
                                    HStack(spacing: 18) {
                                        ForEach(vm.familyMembers, id: \.self.id) { fm in
                                            Button {
                                                selected.append(fm)
                                            } label: {
                                                Badge(
                                                    imgName: fm.role,
                                                    name: fm.name,
                                                    selected: selected.contains(fm)
                                                )
                                            }
                                        }
                                    }
                                    .padding(.horizontal, 24)
                                }
                            }
                    } header: {
                        HStack {
                            Text("Asignee")
                                .font(.body)
                                .textCase(.none)
                                .foregroundColor(Color.black)
                                .padding(.top, -20)
                        }
                    }
                    
                    Section {
                        
                    } header: {
                        HStack {
                            Text("Dependency")
                                .font(.body)
                                .textCase(.none)
                                .foregroundColor(Color.black)
                            Spacer()
                            Image(systemName: "plus")
                                .font(.body)
                        }
                        .padding(.top, -20)
                    }
                }
                
                Button {
                    Task {
                        vm.chore.asignee = selected
                        await vm.createChore()
                        dismiss()
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
            .navigationTitle("Create Chores")
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            Task {
                isLoading.toggle()
                await vm.findAll()
                isLoading.toggle()
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    HStack {
                        Image(systemName: "chevron.backward")
                        Text("Back")
                    }
                }
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
            if imgName == "" {
                imgAsset = "Dad"
            } else {
                imgAsset = imgName
            }
        }
    }
}

struct ChoresAddView_Previews: PreviewProvider {
    static var previews: some View {
        ChoresAddView()
    }
}
