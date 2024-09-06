//
//  ViewController.swift
//  ToDoList
//
//  Created by Артур Миннушин on 03.09.2024.
//

import UIKit

class TaskScreenViewController: UIViewController {
    
    private let taskScreenView = TaskScreenView(frame: .zero)
    private let taskTableViewConfiguration = TaskScreenTableViewConfiguration()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = taskScreenView
    }
    
    override func viewDidLoad() {
        taskScreenView.setupTableView(configuration: taskTableViewConfiguration)
    }
}

