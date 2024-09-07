//
//  TaskScreenViewModel.swift
//  ToDoList
//
//  Created by Артур Миннушин on 05.09.2024.
//

import Foundation
import Combine

class TaskScreenViewModel {
    static let shared = TaskScreenViewModel()
    private let coreDataManager = CoreDataManager.shared
    private let networkManager = NetworkManager.shared
    private let dateManager = DateManager.shared
    private let backGroundQueue = DispatchQueue.global()
    private var flagObtainedAllStartTasks: Bool?
    private var cancelebels: Set<AnyCancellable> = []
    
    init() {
        networkManager.$flagObtainedAllStartTasks
            .sink{flagObtainedAllStartTasks in
                self.flagObtainedAllStartTasks = flagObtainedAllStartTasks
            }.store(in: &cancelebels)
    }
    
    func deleteTaskById(taskId: Int64, completion: @escaping() -> Void) {
        backGroundQueue.async {
            self.coreDataManager.deleteTaskById(taskId: taskId)
            completion()
        }
    }
    
    func getTasks(completion: @escaping(([Int], [Tasks], [Tasks], [Tasks])) -> Void) {
        backGroundQueue.async {
            while !self.flagObtainedAllStartTasks! {}
            let seporatedTasksLists = self.coreDataManager.seporateSavedTasksStatus()
            let tasks = self.coreDataManager.obtaineSavedTasks()
            let completedTasks = seporatedTasksLists.0
                .sorted(by: {$0.taskDate!.compare($1.taskDate!) == .orderedDescending})
            let doTasks = seporatedTasksLists.1
                .sorted(by: {$0.taskDate!.compare($1.taskDate!) == .orderedDescending})
            let result: [Int] = [tasks.count, completedTasks.count, doTasks.count]
            completion((result, tasks, completedTasks, doTasks))
        }
    }
    
    func translateMounthName(mounthName: String) -> String {
        return dateManager.translateMounthYearName(yearMounth: mounthName)
    }
    
    func updateTasks(taskId: Int64, taskName: String,
                     taskDescription: String, taskStatus: Bool, completion: @escaping() -> Void) {
        backGroundQueue.async {
            self.coreDataManager.updateTasks(taskId: taskId, taskName: taskName, taskDescription: taskDescription, taskStatus: taskStatus)
            completion()
        }
    }
    
    func getCurrentDate(completion: @escaping(String) -> Void) {
        backGroundQueue.async {
            completion(self.dateManager.getCurrentDate())
        }
    }
}
