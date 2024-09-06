//
//  TsakScreenTableViewConfiguration.swift
//  ToDoList
//
//  Created by Артур Миннушин on 04.09.2024.
//

import Foundation
import UIKit

class TaskScreenTableViewConfiguration: NSObject, UITableViewDelegate, UITableViewDataSource {
    let cellSpacingHeight: CGFloat = 0
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "TasksCell", for: indexPath) as? TaskScreenTableViewCell else { fatalError() }
        cell.setupTaskInfo(nameTask: "Надо решить задачу по ОРИС", descriptionTask: "Вся инфа лежит в ВК", dateTask: "Сегодня")
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
}
