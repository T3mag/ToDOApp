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
        cell.setupDelegate(delegate: viewController)
        cell.setupTaskInfo(nameTask: task.taskName!,
                           descriptionTask: task.taskDescription!,
                           dateTask: setupDateCell(date: task.taskDate!),
                           statustask: task.taskStatus,
                           taskId: task.taskID)
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
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            viewController?.deleteTaskById(taskId: tasks[indexPath.row].taskID)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewController?.openEddingScreen(task: tasks[indexPath.section])
    }
    
    func setupBindings() {
        viewController?.$tasks
            .sink { [weak self] tasks in 
                self?.tasks = tasks
            }.store(in: &cancelebels)
    }
    
    func setupDateCell(date: Date) -> String{
        let format = DateFormatter()
        format.dateFormat = "dd.MMMM.YYYY"
        let cellDate = format.string(from: date)
        var cellDateLists = cellDate.components(separatedBy: ".")
        
        if cellDateLists[0].first == "0" {
            cellDateLists[0].removeFirst()
        }
        
        return "\(cellDateLists[0]) \(viewController?.translateMounthName(mountName: cellDateLists[1]) ?? "") \(cellDateLists[2])"
    }
}
