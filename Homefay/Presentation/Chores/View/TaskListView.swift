//
//  TaskListView.swift
//  Homefay
//
//  Created by Agung Saputra on 25/07/23.
//

import SwiftUI

struct TaskListView: View {
    @Binding var isAdd: Bool
    
    @State private var name: String = ""
    @State private var selectedId: Int?
    
    var body: some View {
        VStack {
            
        }
        .sheet(isPresented: $isAdd) {
            NavigationStack {
                VStack {
                    Form {
                        TextField("Tasklist Name", text: $name)
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
                            Text("Desi")
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
                                        ForEach([0,1,2,3,4], id: \.self) { d in
                                            Button {
                                                selectedId = d
                                            } label: {
                                                Badge(imgName: "Father", name: "Dad", selected: d == selectedId)
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
                        isAdd.toggle()
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
        }
    }
}

private struct Badge: View {
    var imgName: String
    var name: String
    var selected: Bool
    
    var body: some View {
        VStack {
            Rectangle()
                .foregroundColor(.clear)
                .frame(width: 50, height: 50)
                .background(
                    Image(imgName)
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
    }
}

struct TaskListView_Previews: PreviewProvider {
    static var previews: some View {
        ChoresView()
    }
}
