//
//  ChoresView.swift
//  Homefay
//
//  Created by bernardus kanayari on 24/07/23.
//

import SwiftUI

struct ChoresView: View {
    var body: some View {
        
        @State var isPresented: Bool = false
        @State var searchField: String = ""
        @State var selection: Int = 0
        
        
        NavigationStack {
            VStack {
                Picker(selection: $selection, label: Text("segment")) {
                    Text("All Task").tag(0)
                    Text("Task List").tag(1)
                    Text("Connection").tag(2)
                }
                .background(Color("surfaceColor"))
                .cornerRadius(7)
                .pickerStyle(.segmented)
                .padding(.horizontal)
                //                .padding(.bottom)
                
                
                //MARK: Task
                
                List {
                    //MARK: To Do Section
                    Section {
                        ZStack {
                            NavigationLink(destination: Text("test")) {
                                EmptyView()
                            }
                            .opacity(0)
                            
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
                                
                                Image("girlAvatar")
                                    .offset(y: 15)
                            }
                        }
                        
                        ZStack {
                            NavigationLink(destination: Text("test")) {
                                EmptyView()
                            }
                            .opacity(0)
                            
                            HStack {
                                Image("leaf")
                                
                                VStack(alignment: .leading) {
                                    Text("Potong Rumput")
                                    
                                    Text("08.00")
                                        .font(.caption)
                                    Text("High")
                                        .font(.caption)
                                        .foregroundColor(Color("highTask"))
                                }
                                
                                Spacer()
                                
                                Image("girlAvatar")
                                    .offset(y: 15)
                            }
                        }
                        
                        ZStack {
                            NavigationLink(destination: Text("test")) {
                                EmptyView()
                            }
                            .opacity(0)
                            
                            HStack {
                                Image("wallet")
                                
                                VStack(alignment: .leading) {
                                    Text("Cleaning Oyen Cage")
                                    
                                    Text("08.00")
                                        .font(.caption)
                                    Text("Medium")
                                        .font(.caption)
                                        .foregroundColor(Color("mediumTask"))
                                }
                                
                                Spacer()
                                
                                Image("girlAvatar")
                                    .offset(y: 15)
                            }
                        }
                        
                        
                    } header: {
                        HStack {
                            Text("To-Do")
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundColor(Color.black)
                            
                            Spacer()
                            
                            Button {
                                //add
                            } label: {
                                Image(systemName: "plus")
                                    .padding(.horizontal)
                            }
                            
                            
                            
                        }
                    }
                    
                    
                    Section {
                        ZStack {
                            NavigationLink(destination: Text("test")) {
                                EmptyView()
                            }
                            .opacity(0)
                            
                            
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
                                
                                Image("girlAvatar")
                                    .offset(y: 15)
                            }
                        }
                        
                        ZStack {
                            NavigationLink(destination: Text("test")) {
                                EmptyView()
                            }
                            .opacity(0)
                            
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
                                
                                Image("girlAvatar")
                                    .offset(y: 15)
                            }
                        }
                        
                        ZStack {
                            NavigationLink(destination: Text("test")) {
                                EmptyView()
                            }
                            .opacity(0)
                            
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
                                
                                Image("girlAvatar")
                                    .offset(y: 15)
                            }
                        }
                        
                        
                    } header: {
                        Text("Done")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(Color.black)
                    }
                }
                .listStyle(.sidebar)
//                .scrollContentBackground(.hidden)
//                .background(Color("surfaceColor"))
                .cornerRadius(10)
            }
            .navigationTitle("Chores")
            .searchable(text: $searchField)
            
            //MARK: NavigationBar
            .toolbar {
                //Notification Button
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        print("notif")
                    } label: {
                        Image(systemName: "bell")
                    }
                }
                
                //Add list Button
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        print("add task")
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
    }
}

struct ChoresView_Previews: PreviewProvider {
    static var previews: some View {
        ChoresView()
    }
}
