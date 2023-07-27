//
//  SwiftUIView.swift
//  Homefay
//
//  Created by bernardus kanayari on 27/07/23.
//

import SwiftUI

struct SwiftUIView: View {
    
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack {
            List {
                HStack {
                    Image("profil")
                    
                    VStack(alignment: .leading) {
                        Text("Ayah")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        HStack {
                            Image("dompet")
                                .resizable()
                                .frame(width: 20, height: 20)
                            Image("dompet")
                                .resizable()
                                .frame(width: 20, height: 20)
                            Image("dompet")
                                .resizable()
                                .frame(width: 20, height: 20)
                            Image("dompet").resizable()
                                .frame(width: 20, height: 20)
                            
                        }
                    }
                    
                    Spacer()
                    
                    VStack {
                        Text("available")
                            .padding(.vertical)
                            .foregroundColor(Color("mainColor"))
                        Spacer()
                    }
                }
                
                
                
                HStack {
                    Image("profil")
                    
                    VStack(alignment: .leading) {
                        Text("Ibu")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        HStack {
                            Image("dompet")
                                .resizable()
                                .frame(width: 20, height: 20)
                            Image("dompet")
                                .resizable()
                                .frame(width: 20, height: 20)
                            Image("dompet")
                                .resizable()
                                .frame(width: 20, height: 20)
                            Image("dompet")
                                .resizable()
                                .frame(width: 20, height: 20)
                            
                        }
                    }
                    
                    Spacer()
                    
                    VStack {
                        Text("busy")
                            .padding(.vertical)
                            .foregroundColor(Color.gray)
                        Spacer()
                    }
                        
                }
            }
            .scrollContentBackground(.hidden)
            .background(Color("surfaceColor"))
            .cornerRadius(10)
            
            
            
            .navigationTitle("Keluarga Haji Agung")
            .padding()
            
            .toolbar {
//                //MARK: Edit Button
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    Button {
//                        //Button
//                    } label: {
//                        Image(systemName: "pencil")
//                    }
//                }
//
//                //MARK: Delete Button
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    Button {
//                        //Button
//                    } label: {
//                        Image(systemName: "trash.fill")
//                    }
//                }
                
                //MARK: Share link Button
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        //
                    } label: {
                        Image(systemName: "link")
                    }
                }
            }
            .padding(.horizontal,0)
        }
        .searchable(text: $searchText)
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}
