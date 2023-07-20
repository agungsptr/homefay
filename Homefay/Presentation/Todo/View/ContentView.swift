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
    
    var body: some View {
        NavigationView {
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
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
//                        withAnimation(.easeInOut(duration: 0.25)) {
//                            contentVM.save()
//                        }
                        showingSheet.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingSheet) {
                VStack {
                    Form {
                        TextField("Name", text: $contentVM.family.name)
                        TextField("Unique Invitation", text: $contentVM.family.uniqueId).disabled(true)
                    }
                    Button {
                        contentVM.save()
                        showingSheet.toggle()
                    } label: {
                        Text("Save")
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
