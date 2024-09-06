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
    private let backGroundQueue = DispatchQueue.global()
    private var flagObtainedAllStartTasks: Bool?
    private var cancelebels: Set<AnyCancellable> = []
    
    init() {
        networkManager.$flagObtainedAllStartTasks
            .sink{flagObtainedAllStartTasks in
                self.flagObtainedAllStartTasks = flagObtainedAllStartTasks
            }.store(in: &cancelebels)
    }
    
    func getCountsTasks(completion: @escaping([Int]) -> Void) {
        backGroundQueue.async {
            while !self.flagObtainedAllStartTasks! {}
            let seporatedTasksLists = self.coreDataManager.seporateSavedTasksStatus()
            let allTasks = self.coreDataManager.obtaineSavedTasks().count
            let completedTasks = seporatedTasksLists.0.count
            let doTasks = seporatedTasksLists.1.count
            let result: [Int] = [allTasks, completedTasks, doTasks]
            completion(result)
        }
    }
    
    func getTasks(completion: @escaping(([Tasks], [Tasks], [Tasks])) -> Void) {
        backGroundQueue.async {
            while !self.flagObtainedAllStartTasks! {}
            let seporatedTasksLists = self.coreDataManager.seporateSavedTasksStatus()
            var tasks = self.coreDataManager.obtaineSavedTasks()
            let completedTasks = seporatedTasksLists.0
            let doTasks = seporatedTasksLists.1
            completion((tasks, completedTasks, doTasks))
        }
    }
}
