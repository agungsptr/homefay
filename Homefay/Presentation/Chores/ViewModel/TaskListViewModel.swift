//
//  TaskListViewModel.swift
//  Homefay
//
//  Created by Agung Saputra on 26/07/23.
//

import Foundation
import SwiftUI

@MainActor
class TaskListViewModel: ObservableObject {
    @Published var familyMembers: [ProfileModel] = []
    @Published var taskLists: [TaskListModel] = []
    @Published var chores: [ChoreModel] = []
    @Published var taskList = TaskListModel(
        name: "", asigneeName: "", asigneeId: "", familyId: ""
    )
    @Published var chore = ChoreModel(
        title: "",
        category: "",
        level: "",
        startTime: Date(),
        endTime: Date(),
        asignee: [],
        depend: [""],
        isDone: false,
        listId: "",
        familyId: ""
    )
    
    @AppStorage("userFamilyId") var userFamilyId: String = ""
    
    private lazy var dbFamilyMember = ProfileInjec().useCase()
    private lazy var dbTaskList = TaskListInjec().useCase()
    private lazy var dbChores = ChoreInjec().useCase()
    
    func findAllFamilyMember() async {
        let res = await self.dbFamilyMember.findAll(familyId: UUID(uuidString: userFamilyId)!)
        switch res {
        case .success(let data):
            self.familyMembers = data
        case .failure(let error):
            print(error)
        }
    }
    
    func findAll() async {
        // fetch data family member
        let resFamilyMember = await self.dbFamilyMember.findAll(familyId: UUID(uuidString: userFamilyId)!)
        switch resFamilyMember {
        case .success(let dataFamilyMember):
            self.familyMembers = dataFamilyMember
        case .failure(let errorFamilyMember):
            print(errorFamilyMember)
        }
        
        // fetch data tasklist
        let resTaskList = await self.dbTaskList.findAll(familyId: UUID(uuidString: userFamilyId)!)
        switch resTaskList {
        case .success(let dataTaskList):
            self.taskLists = dataTaskList
        case .failure(let errorTaskList):
            print(errorTaskList)
        }
        
        // fetch data chore
        let resChore = await self.dbChores.findAll(familyId: UUID(uuidString: userFamilyId)!)
        switch resChore {
        case .success(let dataChore):
            self.chores = dataChore
        case .failure(let errorChore):
            print(errorChore)
        }
    }
    
    func createTaskList() async {
        self.taskList.familyId = userFamilyId
        let res = await self.dbTaskList.create(taskList: taskList)
        switch res {
        case .success(let data):
            self.taskList.id = data.id
            self.taskList.name = data.name
            self.taskList.asigneeName = data.asigneeName
            self.taskList.asigneeId = data.asigneeId
            self.taskList.familyId = userFamilyId
            await self.findAll()
        case .failure(let error):
            print(error)
        }
    }
    
    func createChore() async {
        self.chore.familyId = userFamilyId
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
            self.chore.familyId = userFamilyId
            await self.findAll()
        case .failure(let error):
            print(error)
        }
    }
    
    func deleteChore(id: UUID) async {
        let res = await self.dbChores.delete(id: id)
        switch res {
        case .success(_):
            print("success delete")
        case .failure(let error):
            print(error)
        }
    }
    
    func markIsDone(id: UUID, data: ChoreModel) async {
        let res = await self.dbChores.update(
            id: id,
            chore: ChoreModel(
                title: data.title,
                category: data.category,
                level: data.level,
                startTime: data.startTime,
                endTime: data.endTime,
                asignee: data.asignee,
                depend: data.depend,
                isDone: true,
                listId: data.listId,
                familyId: data.familyId
            )
        )
        switch res {
        case .success(_):
            await self.findAll()
        case .failure(let error):
            print(error)
        }
    }
    
    func markIsUndone(id: UUID, data: ChoreModel) async {
        let res = await self.dbChores.update(
            id: id,
            chore: ChoreModel(
                title: data.title,
                category: data.category,
                level: data.level,
                startTime: data.startTime,
                endTime: data.endTime,
                asignee: data.asignee,
                depend: data.depend,
                isDone: false,
                listId: data.listId,
                familyId: data.familyId
            )
        )
        switch res {
        case .success(_):
            await self.findAll()
        case .failure(let error):
            print(error)
        }
    }
    
    func editChore(id: UUID, data: ChoreModel) async {
        let res = await self.dbChores.update(
            id: id,
            chore: ChoreModel(
                title: data.title,
                category: data.category,
                level: data.level,
                startTime: data.startTime,
                endTime: data.endTime,
                asignee: data.asignee,
                depend: data.depend,
                isDone: data.isDone,
                listId: data.listId,
                familyId: data.familyId
            )
        )
        switch res {
        case .success(_):
            await self.findAll()
        case .failure(let error):
            print(error)
        }
    }
}
