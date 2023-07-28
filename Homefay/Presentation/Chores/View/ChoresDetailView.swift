//
//  Detail Chores.swift
//  Famie
//
//  Created by Anita Saragih on 28/07/23.
//

import SwiftUI

struct ChoresDetailView: View {
    @State private var dependency = false
    
    var chore: ChoreModel
    
    var body: some View {
        NavigationStack{
            VStack {
                Form {
                    Section {
                        Text(chore.title)
                            .foregroundColor(.gray)
                    } header: {
                        Text("Chores Name")
                            .font(.body)
                            .foregroundColor(Color.black)
                            .textCase(.none)
                    } .headerProminence(.increased)
                    
                    List {
                        HStack {
                            Text("Category")
                            Spacer()
                            Text(chore.category)
                                .foregroundColor(.gray)
                        }
                        HStack{
                            Text("Difficulty Level")
                            Spacer()
                            Text(chore.level)
                                .foregroundColor(.gray)
                        }
                        HStack{
                            Text("Schedule")
                            Spacer()
                            Text("\(chore.startTime.formatted(date: .omitted, time: .shortened)) - \(chore.endTime.formatted(date: .omitted, time: .shortened))")
                                .foregroundColor(.gray)
                        }
                        HStack{
                            Text("Assignee")
                            Spacer()
                            Text(asigneeText(chore.asignee))
                                .foregroundColor(.gray)
                        }
                        VStack{
                            HStack{
                                Text("Dependency")
                                Spacer()
                                Image(systemName: dependency ? "chevron.up" : "chevron.down")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 13)
                            }.onTapGesture {
                                self.dependency.toggle()
                            }
                            if dependency{
                                VStack{
                                    HStack{
                                        Text("Yari, 06.00 PM - 07.00 PM")
                                        Spacer()
                                        Text("Launderer")
                                            .foregroundColor(.gray)
                                    }
                                }
                                .padding(.top, 8)
                            }
                        }
                    }
                }
                Button {
                    
                } label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color("PrimaryColor"))
                            .frame(width: 358, height: 50, alignment: .center)
                        Text("Mark as Done")
                            .foregroundColor(.white)
                    }
                }
                
                
            }
            .navigationTitle("Detail Chores")
        }
    }
    
    func asigneeText(_ data: [FamilyMemberModel]) -> String {
        let text = data.map { member in
            member.name
        }
        return text.joined(separator: ", ")
    }
}

struct ChoresDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ChoresDetailView(chore: ChoreModel(title: "Wash Dishes", category: "Dished Cleaning", level: "Mid", startTime: Date(), endTime: Date(), asignee: [FamilyMemberModel(familyId: "id", name: "name", role: "Dad", userId: "id"), FamilyMemberModel(familyId: "id", name: "name2", role: "Dad", userId: "id")], depend: [], isDone: false, listId: "id"))
    }
}
