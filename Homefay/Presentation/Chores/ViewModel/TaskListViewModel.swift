//
//  TaskListViewModel.swift
//  Homefay
//
//  Created by Agung Saputra on 26/07/23.
//

import Foundation

@MainActor
class TaskListViewModel: ObservableObject {
    @Published var familyMembers: [FamilyMemberModel] = []
    @Published var taskLists: [TaskListModel] = []
    @Published var chores: [ChoreModel] = []
    @Published var taskList = TaskListModel(
        name: "", asigneeName: "", asigneeId: ""
    )
    @Published var chore = ChoreModel(
        title: "",
        category: "",
        level: "",
        startTime: Date(),
        endTime: Date(),
        asignee: [],
        depend: [""],
        isDone: false
    )
    
    private lazy var dbFamilyMember = FamilyMemberInjec().useCase()
    private lazy var dbTaskList = TaskListInjec().useCase()
    private lazy var dbChores = ChoreInjec().useCase()
    
    func findAllFamilyMember() async {
        let res = await self.dbFamilyMember.findAll()
        switch res {
        case .success(let data):
            self.familyMembers = data
        case .failure(let error):
            print(error)
        }
    }
    
    func findAll() async {
        // fetch data family member
        let resFamilyMember = await self.dbFamilyMember.findAll()
        switch resFamilyMember {
        case .success(let dataFamilyMember):
            self.familyMembers = dataFamilyMember
        case .failure(let errorFamilyMember):
            print(errorFamilyMember)
        }
        
        // fetch data tasklist
        let resTaskList = await self.dbTaskList.findAll()
        switch resTaskList {
        case .success(let dataTaskList):
            self.taskLists = dataTaskList
        case .failure(let errorTaskList):
            print(errorTaskList)
        }
        
        // fetch data chore
        let resChore = await self.dbChores.findAll()
        switch resChore {
        case .success(let dataChore):
            self.chores = dataChore
        case .failure(let errorChore):
            print(errorChore)
        }
    }
    
    func createTaskList() async {
        let res = await self.dbTaskList.create(taskList: taskList)
        switch res {
        case .success(let data):
            self.taskList.id = data.id
            self.taskList.name = data.name
            self.taskList.asigneeName = data.asigneeName
            self.taskList.asigneeId = data.asigneeId
            await self.findAll()
        case .failure(let error):
            print(error)
        }
    }
    
    func createChore() async {
        let res = await self.dbChores.create(chore: chore)
        switch res {
        case .success(let data):
            self.chore.id = data.id
            self.chore.title = data.title
            self.chore.category = data.category
            self.chore.level = data.level
            self.chore.startTime = data.startTime
            self.chore.endTime = data.endTime
            self.chore.asignee = data.asignee
            self.chore.depend = data.depend
            await self.findAll()
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
