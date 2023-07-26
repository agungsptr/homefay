//
//  ChoresView.swift
//  Homefay
//
//  Created by Agung Saputra on 25/07/23.
//

import SwiftUI

struct ChoresView: View {
    @State private var segment = 1
    @State private var searchText = ""
    @State private var isAdd = false
    
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
                    AllTaskView(isAdd: $isAdd)
                case 1:
                    TaskListView(isAdd: $isAdd)
                case 2:
                    ConnectionView(isAdd: $isAdd)
                default:
                    AllTaskView(isAdd: $isAdd)
                }
                Spacer()
            }
            .scrollIndicators(.hidden)
            .navigationTitle("Chores")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        isAdd = true
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
