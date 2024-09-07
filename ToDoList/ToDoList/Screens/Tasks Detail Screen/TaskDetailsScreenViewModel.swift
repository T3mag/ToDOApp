//
//  TaskDetailsScreenViewModel.swift
//  ToDoList
//
//  Created by Артур Миннушин on 06.09.2024.
//

import Foundation
import UIKit

class TaskDetailsScreenViewModel {
    
    private let dateManager = DateManager.shared
    private let coreDataManager = CoreDataManager.shared
    static let shared = TaskDetailsScreenViewModel()
    private let viewController: TaskDetailsScreenViewController!
    private var mainViewController: TaskScreenViewController!
    
    init() {
        viewController = TaskDetailsScreenViewController()
        viewController.setupViewModel(viewModel: self)
    }
    
    func setupScreenForCreateTasks(viewControllerForPresent: TaskScreenViewController) {
        mainViewController = viewControllerForPresent
        viewController?.setupForCreateTasks()
        viewControllerForPresent.present(viewController!, animated: true)
    }
    
    func setupScreeForEdditingTasks(task: Tasks, viewControllerForPresent: TaskScreenViewController) {
        mainViewController = viewControllerForPresent
        viewController?.setupForEditingTask(task: task)
        viewControllerForPresent.present(viewController!, animated: true)
    }
    
    func updateMainViewController() {
        mainViewController.updateTasksInfo()
    }
    
    func getDateString(date: Date) -> String {
        let format = DateFormatter()
        format.dateFormat = "dd.MMMM.YYYY"
        let cellDate = format.string(from: date)
        var cellDateLists = cellDate.components(separatedBy: ".")
        
        if cellDateLists[0].first == "0" {
            cellDateLists[0].removeFirst()
        }
        return "\(cellDateLists[0]) \(dateManager.translateMounthYearName(yearMounth: cellDateLists[1])) \(cellDateLists[2])"
    }
    
    func updateTaskInfo(taskId: Int64, taskName: String,
                     taskDescription: String, taskStatus: Bool, completion: @escaping() -> Void) {
        DispatchQueue.global().async {
            self.coreDataManager.updateTasks(taskId: taskId, taskName: taskName, taskDescription: taskDescription, taskStatus: taskStatus)
            completion()
        }
    }
    
    func createTaskInfo(taskName: String,
                     taskDescription: String, taskStatus: Bool, completion: @escaping() -> Void) {
        DispatchQueue.global().async {
            self.coreDataManager.addTasks(taskName: taskName, taskDescription: taskDescription, taskStatus: taskStatus)
            completion()
        }
    }
}
