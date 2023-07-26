//
//  TestView.swift
//  Homefay
//
//  Created by Agung Saputra on 26/07/23.
//

import SwiftUI

struct TestView: View {
    @State private var selectedCategory = "Launder"
    @State private var sliderValue: Float = 0
    
    var body: some View {
        VStack {
            List {
                Section {
                    Picker("", selection: $selectedCategory) {
                        Text("Garden").tag("Garden")
                        Text("Launder").tag("Launder")
                        Text("Kitchen").tag("Kitchen")
                    }
                    .pickerStyle(.wheel)
                    .frame(maxHeight: 150)
                } header: {
                    HStack {
                        Text("Category")
                            .foregroundColor(Color.black)
                            .textCase(.none)
                        Spacer()
                        Text(selectedCategory)
                            .textCase(.none)
                    }
                }
                Section {
                    Slider(value: $sliderValue,
                           in: 0...10,
                           step: 5) { didChange in
                        print("Did change: \(didChange)")
                    }.padding()
                } header: {
                    HStack {
                        Text("Difficulty Level")
                            .foregroundColor(Color.black)
                            .textCase(.none)
                        Spacer()
                        Text("\(sliderValue)")
                            .textCase(.none)
                    }
                }
                Section {
                    
                } header: {
                    HStack {
                        Text("Schedule")
                            .foregroundColor(Color.black)
                            .textCase(.none)
                        Spacer()
                        Text("07.00 PM - 08.00 PM")
                            .textCase(.none)
                    }
                }
                Section {
                    
                } header: {
                    HStack {
                        Text("Asignee")
                            .textCase(.none)
                            .foregroundColor(Color.black)
                        Spacer()
                        Text("Desi")
                            .textCase(.none)
                    }
                }
                Section {
                    
                } header: {
                    HStack {
                        Text("Connecting Chores")
                            .textCase(.none)
                            .foregroundColor(Color.black)
                        Spacer()
                        Image(systemName: "plus")
                    }
                }
            }
            .listStyle(.sidebar)
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
