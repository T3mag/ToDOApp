//
//  TaskDetailsScreenViewController.swift
//  ToDoList
//
//  Created by Артур Миннушин on 06.09.2024.
//

import UIKit

class TaskDetailsScreenViewController: UIViewController {

    private var viewModel: TaskDetailsScreenViewModel?
    private var customView = TaskDetailsScreenView(frame: .zero)
    private let mainQueue = DispatchQueue.main
    
    init() {
        super.init(nibName: nil, bundle: nil)
        customView.setupViewController(viewController: self)
    }
    
    func setupViewModel(viewModel: TaskDetailsScreenViewModel) {
        self.viewModel = viewModel
    }
    
    func setupForCreateTasks() {
        customView.setupForCreateTask()
    }
    
    func setupForEditingTask(task: Tasks) {
        customView.setupForEditingTask(task: task)
    }
    
    func createTaskInfo(taskname: String, taskDescription: String,
                        taskStatus: Bool) {
        self.mainQueue.async {
            self.dismiss(animated: true)
        }
        viewModel?.createTaskInfo(taskName: taskname, taskDescription: taskDescription, taskStatus: taskStatus, completion: {
            self.viewModel?.updateMainViewController()
        })
    }
    
    func updateTaskInfo(taskname: String, taskDescription: String,
                        taskStatus: Bool, taskId: Int64) {
        self.mainQueue.async {
            self.dismiss(animated: true)
        }
        viewModel?.updateTaskInfo(taskId: taskId, taskName: taskname,
                                  taskDescription: taskDescription, taskStatus: taskStatus, completion: {
            self.viewModel?.updateMainViewController()
        })
    }
    
    func getDateString(date: Date) -> String {
        return viewModel!.getDateString(date: date)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = customView
    }
    
}
