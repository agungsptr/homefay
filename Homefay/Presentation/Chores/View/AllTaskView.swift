//
//  AllTaskView.swift
//  Homefay
//
//  Created by Agung Saputra on 25/07/23.
//

import SwiftUI

struct AllTaskView: View {
    @Binding var isAdd: Bool
    
    var body: some View {
        VStack {
            
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
