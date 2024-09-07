//
//  ViewController.swift
//  ToDoList
//
//  Created by Артур Миннушин on 03.09.2024.
//

import UIKit
import Combine

protocol CellDelegate: AnyObject {
    func updateTaskInfo(taskId: Int64, newStatus: Bool, newName: String, newDescription: String)
}

class TaskScreenViewController: UIViewController {
    
    private let taskScreenView = TaskScreenView(frame: .zero)
    private var taskTableViewConfiguration: TaskScreenTableViewConfiguration?
    private var taskScreenViewModel: TaskScreenViewModel?
    private let backgroundQueue = DispatchQueue.global()
    private let mainQueue = DispatchQueue.main
    @Published var tasks: [Tasks] = []
    
    init(viewModel: TaskScreenViewModel) {
        super.init(nibName: nil, bundle: nil)
        taskScreenViewModel = viewModel
        taskScreenView.setupViewController(viewController: self)
        taskTableViewConfiguration = TaskScreenTableViewConfiguration(viewControler: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = taskScreenView
        updateTasksInfo()
        setupCurrentDate()
    }
    
    override func viewDidLoad() {
        taskScreenView.setupTableView(configuration: taskTableViewConfiguration!)
    }
    
    func setupCurrentDate() {
        taskScreenViewModel!.getCurrentDate(completion: { date in
            self.mainQueue.async {
                self.taskScreenView.setupDate(date: date)
            }
        })
    }
    
    func translateMounthName(mountName: String) -> String {
        return taskScreenViewModel?.translateMounthName(mounthName: mountName) ?? "Ошибка"
    }
    
    func deleteTaskById(taskId: Int64) {
        taskScreenViewModel?.deleteTaskById(taskId: taskId, completion: {
            self.updateTasksInfo()
        })
    }
    
    func openCreateScreen() {
        let viewModel = TaskDetailsScreenViewModel.shared
        viewModel.setupScreenForCreateTasks(viewControllerForPresent: self)
    }
    
    func openEddingScreen(task: Tasks) {
        let viewModel = TaskDetailsScreenViewModel.shared
        viewModel.setupScreeForEdditingTasks(task: task, viewControllerForPresent: self)
    }
    
    func updateTasksInfo() {
        taskScreenViewModel?.getTasks(completion: { result in
            for i in 0..<self.taskScreenView.getButtonsStatus().count {
                if self.taskScreenView.getButtonsStatus()[i] == true {
                    if i == 0 {
                        self.tasks = result.1
                    } else if i == 1 {
                        self.tasks = result.2
                    } else if i == 2 {
                        self.tasks = result.3
                    }
                }
            }
            self.mainQueue.async {
                let counters = result.0
                self.taskScreenView.updateCountersTask(totalTasks: counters[0],
                                                       completeTasks: counters[1],
                                                       inWorkTasks: counters[2])
            }
            self.mainQueue.sync {
                self.taskScreenView.reloadData()
            }
        })
    }
}

extension TaskScreenViewController: CellDelegate {
    func updateTaskInfo(taskId: Int64, newStatus: Bool,
                        newName: String, newDescription: String) {
        self.taskScreenViewModel?.updateTasks(taskId: taskId, taskName: newName, taskDescription: newDescription, taskStatus: newStatus, completion: {
            self.updateTasksInfo()
            self.mainQueue.async {
                self.taskScreenView.reloadData()
            }
        })
    }
}

