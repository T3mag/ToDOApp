//
//  ViewController.swift
//  ToDoList
//
//  Created by Артур Миннушин on 03.09.2024.
//

import UIKit
import Combine

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
        updateTasksCountres()
        updateTasksLists(status: taskScreenView.getButtonsStatus())
    }
    
    override func viewDidLoad() {
        taskScreenView.setupTableView(configuration: taskTableViewConfiguration!)
    }
    
    func updateTasksCountres() {
        taskScreenViewModel?.getCountsTasks(completion: { result in
            self.mainQueue.async {
                self.taskScreenView.updateCountersTask(totalTasks: result[0],
                                                       completeTasks: result[1],
                                                       inWorkTasks: result[2])
            }
        })
    }
    func updateTasksLists(status: [Bool]) {
        self.taskScreenViewModel?.getTasks(completion: {tasks in
            for i in 0..<status.count {
                if status[i] == true {
                    if i == 0 {
                        self.tasks = tasks.0
                    }
                    if i == 1 {
                        self.tasks = tasks.1
                    }
                    if i == 2 {
                        self.tasks = tasks.2
                    }
                }
            }
            self.mainQueue.async {
                self.taskScreenView.reloadData()
            }
        })
    }
}

