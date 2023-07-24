//
//  ContentView.swift
//  CleanSwift
//
//  Created by Agung Saputra on 16/07/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var contentVM = ContentViewModel()
    @State private var showingSheet = false
    @State private var isLoading = false
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
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
                        fetchData()
                    }
                    .onAppear {
                        fetchData()
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
                        SheetAddView(contentVM: contentVM, showingSheet: $showingSheet)
                    }
                    Button {
                        Task {
                            isLoading.toggle()
                            let id = contentVM.families[0].id!
                            await contentVM.update(id: id)
                            isLoading.toggle()
                        }
                        
                    } label: {
                        Text("Update")
                    }
                }
                if isLoading {
                    LoadingView()
                }
            }
        }
    }
    
    private func fetchData() {
        Task {
            isLoading.toggle()
            await contentVM.findAll()
            isLoading.toggle()
        }
    }
}

private struct SheetAddView: View {
    @StateObject var contentVM: ContentViewModel
    @Binding var showingSheet: Bool
    
    @State private var isLoading = false
    
    var body: some View {
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
                        await contentVM.create()
                        showingSheet.toggle()
                        isLoading = false
                    }
                } label: {
                    Text("Save")
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
        ZStack {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .black))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
