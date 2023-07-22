//
//  ContentView.swift
//  CleanSwift
//
//  Created by Agung Saputra on 16/07/23.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject private var contentVM = ContentViewModel()
    @State private var showingSheet = false
    @State private var isLoading = false
    
    var body: some View {
        NavigationView {
            ZStack {
                List {
                    ForEach(contentVM.families) { family in
                        NavigationLink {
                            VStack {
                                Text(family.name)
                                Text(family.uniqueId)
                            }
                        } label: {
                            Text(family.name)
                        }
                    }
                    .onDelete { offsets in
                        for i in offsets {
                            Task {
                                let id = contentVM.families[i].id!
                                await contentVM.delete(id: id)
                            }
                        }
                    }
                }
                .refreshable {
                    Task {
                        await contentVM.findAll()
                    }
                }
                .onAppear {
                    Task {
                        await contentVM.findAll()
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            showingSheet.toggle()
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                }
                .sheet(isPresented: $showingSheet) {
                    ZStack {
                        VStack {
                            Form {
                                TextField("Name", text: $contentVM.family.name)
                                TextField("Unique Invitation", text: $contentVM.family.uniqueId)
                                    .disabled(true)
                            }
                            Button {
                                Task {
                                    isLoading = true
                                    await contentVM.save()
                                    showingSheet.toggle()
                                    isLoading = false
                                }
                            } label: {
                                Text("Save")
                            }
                        }
                        if isLoading {
                            ZStack {
                                Color(.systemBackground)
                                    .ignoresSafeArea(.all)
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle(tint: .black))
                                    .scaleEffect(3)
                            }
                        }
                    }
                }
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
