//
//  AllTaskView.swift
//  Homefay
//
//  Created by Agung Saputra on 25/07/23.
//

import SwiftUI

struct AllTaskView: View {
    @Binding var isAdd: Bool
    
    @State private var selection = "Red"
    let colors = ["Red", "Green", "Blue", "Black", "Tartan"]
    
    var body: some View {
        VStack {
            Picker("Select a paint color", selection: $selection) {
                            ForEach(colors, id: \.self) {
                                Text($0)
                            }
                        }
        }.sheet(isPresented: $isAdd) {
            Text("Alltask")
        }
    }
}

struct AllTaskView_Previews: PreviewProvider {
    static var previews: some View {
        ChoresView()
    }
}
