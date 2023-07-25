//
//  TaskListViewModel.swift
//  Homefay
//
//  Created by Agung Saputra on 26/07/23.
//

import Foundation

@MainActor
class TaskListViewModel: ObservableObject {
    @Published var taskLists: [TaskListModel] = []
    @Published var taskList = TaskListModel(
        name: "", asigneeName: "", asigneeId: ""
    )
    @Published var familyMembers: [FamilyMemberModel] = []
    
    private lazy var db = TaskListInjec().useCase()
    private lazy var dbFamilyMember = FamilyMemberInjec().useCase()
    
    func findAllFamilyMember() async {
        let res = await self.dbFamilyMember.findAll()
        switch res {
        case .success(let data):
            self.familyMembers = data
        case .failure(let error):
            print(error)
        }
    }
    
    func create() async {
        let res = await self.db.create(taskList: taskList)
        switch res {
        case .success(let data):
            self.taskList.id = data.id
            self.taskList.name = data.name
            self.taskList.asigneeName = data.asigneeName
            self.taskList.asigneeId = data.asigneeId
        case .failure(let error):
            print(error)
        }
    }
    
//    func delete(id: UUID) async {
//        let res = await self.db.delete(id: id)
//        switch res {
//        case .success(_):
//            await self.findAll()
//        case .failure(let error):
//            print(error)
//        }
//    }
//
//    func update(id: UUID) async {
//        let res = await self.db.update(
//            id: id,
//            family: FamilyModel(
//                id: nil,
//                name: "update",
//                uniqueId: "",
//                createdBy: self.family.createdBy
//            )
//        )
//        switch res {
//        case .success(_):
//            await self.findAll()
//        case .failure(let error):
//            print(error)
//        }
//    }
}
