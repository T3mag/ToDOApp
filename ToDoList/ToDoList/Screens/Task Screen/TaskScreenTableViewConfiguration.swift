//
//  TsakScreenTableViewConfiguration.swift
//  ToDoList
//
//  Created by Артур Миннушин on 04.09.2024.
//

import UIKit
import Combine

class TaskScreenTableViewConfiguration: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    private let cellSpacingHeight: CGFloat = 0
    private var viewController: TaskScreenViewController?
    private var tasks: [Tasks] = []
    private var cancelebels: Set<AnyCancellable> = []
    
    init(viewControler: TaskScreenViewController) {
        super.init()
        self.viewController = viewControler
        setupBindings()
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "TasksCell", for: indexPath) as? TaskScreenTableViewCell else { fatalError() }
        let task: Tasks = tasks[indexPath.section]
        cell.setupTaskInfo(nameTask: task.taskName!,
                           descriptionTask: task.taskDescription!,
                           dateTask: "Сегодня",
                           statustask: task.taskStatus)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
        
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return cellSpacingHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    func setupBindings() {
        viewController?.$tasks
            .sink { [weak self] tasks in 
                self?.tasks = tasks
            }.store(in: &cancelebels)
    }
}
