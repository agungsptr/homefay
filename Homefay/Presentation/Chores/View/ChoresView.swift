//
//  ChoresView.swift
//  Homefay
//
//  Created by Agung Saputra on 25/07/23.
//

import SwiftUI

struct ChoresView: View {
    @State private var segment = 0
    @State private var searchText = ""
    
    @State private var allTaskAdd = false
    @State private var taskListAdd = false
    @State private var connectionAdd = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Picker("", selection: $segment) {
                    Text("All Task").tag(0)
                    Text("Tasklist").tag(1)
                    Text("Connection").tag(2)
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)
                
                switch segment {
                case 0:
                    AllTaskView(isAdd: $allTaskAdd)
                case 1:
                    TaskListView(isAdd: $taskListAdd)
                case 2:
                    ConnectionView(isAdd: $connectionAdd)
                default:
                    AllTaskView(isAdd: $allTaskAdd)
                }
                Spacer()
            }
            .scrollIndicators(.hidden)
            .navigationTitle("Chores")
            .navigationDestination(isPresented: $allTaskAdd) {
                ChoresAddView()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        if segment == 0 {
                            allTaskAdd = true
                        } else {
                            allTaskAdd = false
                        }
                        if segment == 1 {
                            taskListAdd = true
                        } else {
                            taskListAdd = false
                        }
                        if segment == 3 {
                            connectionAdd = true
                        } else {
                            connectionAdd = false
                        }
                    } label: {
                        switch segment {
                        case 0:
                            Text("Add Task")
                        case 1:
                            Text("Add Tasklist")
                        case 2:
                            Text("Add Task")
                        default:
                            Text("Add Task")
                        }
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        
                    } label: {
                        Image(systemName: "bell")
                    }
                }
            }
        }
        .searchable(text: $searchText)
    }
}

struct ChoresView_Previews: PreviewProvider {
    static var previews: some View {
        ChoresView()
    }
}
