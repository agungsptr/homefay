//
//  AllTaskView.swift
//  Homefay
//
//  Created by Agung Saputra on 25/07/23.
//

import SwiftUI

struct AllTaskView: View {
    @Binding var isAdd: Bool
    
    @State private var isLoading = false
    @StateObject private var vm = TaskListViewModel()
    
    var body: some View {
        ZStack {
            List {
                Section {
                    ForEach(vm.chores) { ch in
                        if !ch.isDone {
                            NavigationLink {
                                ChoresDetailView(chore: ch)
                            } label: {
                                ChoreItemView(
                                    ctg: ch.category,
                                    title: ch.title,
                                    dificulty: ch.level,
                                    startTime: ch.startTime,
                                    endTime: ch.endTime,
                                    asignRole: ch.asignee.count > 0 ? ch.asignee[0].role ?? "Dad" : "Dad"
                                )
                            }
                        }
                    }
                } header: {
                    HStack {
                        Text("Todo")
                            .textCase(.none)
                            .font(.headline)
                            .fontWeight(.semibold)
                            .foregroundColor(Color.black)
                    }
                }
                Section {
                    ForEach(vm.chores) { ch in
                        if ch.isDone {
                            NavigationLink {
                                ChoresDetailView(chore: ch)
                            } label: {
                                ChoreItemView(
                                    ctg: ch.category,
                                    title: ch.title,
                                    dificulty: ch.level,
                                    startTime: ch.startTime,
                                    endTime: ch.endTime,
                                    asignRole: ch.asignee.count > 0 ? ch.asignee[0].role ?? "Dad" : "Dad"
                                )
                            }
                        }
                    }
                } header: {
                    HStack {
                        Text("Done")
                            .textCase(.none)
                            .font(.headline)
                            .fontWeight(.semibold)
                            .foregroundColor(Color.black)
                    }
                }
            }
            .listStyle(.sidebar)
            .cornerRadius(10)
            .onAppear {
                Task {
                    isLoading.toggle()
                    await vm.findAll()
                    isLoading.toggle()
                }
            }
            if isLoading {
                LoadingView()
            }
        }
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

private struct ChoreItemView: View {
    var ctg: String
    var title: String
    var dificulty: String
    var startTime: Date
    var endTime: Date
    var asignRole: String
    
    var body: some View {
        HStack {
            Image(ctg)
                .resizable()
                .scaledToFit()
                .frame(width: 46)
            VStack(alignment: .leading) {
                Text(title)
                Text("\(startTime.formatted(date: .omitted, time: .shortened)) - \(endTime.formatted(date: .omitted, time: .shortened))")
                    .font(.caption)
                Text(dificulty)
                    .font(.caption)
                    .foregroundColor(Color("mediumTask"))
            }
            Spacer()
            VStack {
                Spacer()
                Image(asignRole)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 32)
            }
            .padding(.vertical, 6)
        }
        .padding(.vertical, 2)
    }
}

struct AllTaskView_Previews: PreviewProvider {
    static var previews: some View {
        ChoresView()
    }
}
