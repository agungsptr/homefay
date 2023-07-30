//
//  Test2View.swift
//  Homefay
//
//  Created by Agung Saputra on 26/07/23.
//

import SwiftUI

struct Test2View: View {
    var body: some View {
        ZStack {
            VStack {
                Text("Hellow")
                List {
                    Text("Item 1")
                    Text("Item 2")
                    Text("Item 3")
                }
            }
        }
    }
}

struct Test2View_Previews: PreviewProvider {
    static var previews: some View {
        Test2View()
    }
}
