//
//  TaskScreenView.swift
//  ToDoList
//
//  Created by Артур Миннушин on 03.09.2024.
//

import UIKit

class TaskScreenView: UIView {
    
    private var buttonStatus: [Bool] = [true, false, false]
    private var viewControler: TaskScreenViewController?
    private lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.text = "Мои задачи"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.text = "Вторник, 23 сентября"
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var addTaskButton: UIButton = {
        let button = UIButton()
        let action = UIAction{ [weak self] _ in
            self?.viewControler?.openCreateScreen()
        }
        button.addAction(action, for: .touchUpInside)
        button.setTitle("  + Новая задача  ", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        button.backgroundColor = UIColor(red: 227/255, green: 235/255, blue: 249/255, alpha: 1)
        button.setTitleColor(UIColor(red: 75/255, green: 124/255, blue: 231/255, alpha: 1), for: .normal)
        button.layer.cornerRadius = 15
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private lazy var tasksListTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(TaskScreenTableViewCell.self, forCellReuseIdentifier: "TasksCell")
        tableView.backgroundColor = .clear
        tableView.separatorColor = .clear
        return tableView
    }()
    private lazy var allTaskButton: UIButton = {
        let button = UIButton()
        let action = UIAction { [weak self] _ in
            self?.buttonStatus = [true, false, false]
            self?.changeTypeTasks()
        }
        button.backgroundColor = .clear
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addAction(action, for: .touchUpInside)
        return button
    }()
    private lazy var allTasksLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Все"
        label.textColor = UIColor(red: 49/255, green: 89/255, blue: 235/255, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 5
        label.sizeToFit()
        return label
    }()
    private lazy var countTasksLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = " 0 "
        label.textColor = .white
        label.backgroundColor = UIColor(red: 49/255, green: 89/255, blue: 235/255, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 10)
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 5
        label.sizeToFit()
        return label
    }()
    private lazy var devidingLineLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor(red: 223/255, green: 223/255, blue: 223/255, alpha: 1)
        return label
    }()
    private lazy var completeTasksButton: UIButton = {
        let button = UIButton()
        let action = UIAction { [weak self] _ in
            self?.buttonStatus = [false, true, false]
            self?.changeTypeTasks()
        }
        button.backgroundColor = .clear
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addAction(action, for: .touchUpInside)
        return button
    }()
    private lazy var completeTasksLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Выполненые"
        label.textColor = UIColor(red: 183/255, green: 183/255, blue: 183/255, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 5
        label.sizeToFit()
        return label
    }()
    private lazy var countCompleteTasksLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = " 0 "
        label.textColor = .white
        label.backgroundColor = UIColor(red: 217/255, green: 217/255, blue: 217/255, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 10)
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 5
        label.sizeToFit()
        return label
    }()
    private lazy var doTasksButton: UIButton = {
        let button = UIButton()
        let action = UIAction { [weak self] _ in
            self?.buttonStatus = [false, false, true]
            self?.changeTypeTasks()
        }
        button.backgroundColor = .clear
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addAction(action, for: .touchUpInside)
        return button
    }()
    private lazy var doTasksLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Делаю"
        label.textColor = UIColor(red: 183/255, green: 183/255, blue: 183/255, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 5
        label.sizeToFit()
        return label
    }()
    private lazy var countDoTasksLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = " 0 "
        label.textColor = .white
        label.backgroundColor = UIColor(red: 217/255, green: 217/255, blue: 217/255, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 10)
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 5
        label.sizeToFit()
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayoutHeaders()
        setupLayoutTasksTypes()
        setupLayoutTasksList()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func reloadData() {
        tasksListTableView.reloadData()
    }
    
    func getButtonsStatus() -> [Bool] {
        return buttonStatus
    }
    
    func setupViewController(viewController: TaskScreenViewController) {
        self.viewControler = viewController
    }
    
    func setupTableView(configuration: TaskScreenTableViewConfiguration) {
        tasksListTableView.dataSource = configuration
        tasksListTableView.delegate = configuration
    }
    
    func updateCountersTask(totalTasks: Int, completeTasks: Int, inWorkTasks: Int) {
        countTasksLabel.text = " \(totalTasks) "
        countCompleteTasksLabel.text = " \(completeTasks) "
        countDoTasksLabel.text = " \(inWorkTasks) "
        countTasksLabel.reloadInputViews()
        countCompleteTasksLabel.reloadInputViews()
        countDoTasksLabel.reloadInputViews()
    }
    
    func setupLayoutHeaders() {
        addSubview(headerLabel)
        addSubview(dateLabel)
        addSubview(addTaskButton)
        addSubview(tasksListTableView)
        
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(
                equalTo: safeAreaLayoutGuide.topAnchor, constant: 15),
            headerLabel.leadingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 15),
            dateLabel.topAnchor.constraint(
                equalTo: headerLabel.bottomAnchor, constant: 5),
            dateLabel.leadingAnchor.constraint(
                equalTo: headerLabel.leadingAnchor),
            addTaskButton.topAnchor.constraint(
                equalTo: headerLabel.topAnchor, constant: -3),
            addTaskButton.bottomAnchor.constraint(
                equalTo: dateLabel.bottomAnchor, constant: -3),
            addTaskButton.trailingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -15)
        ])
    }
    
    func setupLayoutTasksTypes() {
        addSubview(allTaskButton)
        addSubview(allTasksLabel)
        addSubview(countTasksLabel)
        addSubview(devidingLineLabel)
        addSubview(completeTasksButton)
        addSubview(completeTasksLabel)
        addSubview(countCompleteTasksLabel)
        addSubview(doTasksButton)
        addSubview(doTasksLabel)
        addSubview(countDoTasksLabel)
        
        NSLayoutConstraint.activate([
            allTaskButton.topAnchor.constraint(
                equalTo: dateLabel.bottomAnchor, constant: 20),
            allTaskButton.leadingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 15),
            allTasksLabel.centerYAnchor.constraint(
                equalTo: allTaskButton.centerYAnchor),
            allTasksLabel.leadingAnchor.constraint(
                equalTo: allTaskButton.leadingAnchor),
            countTasksLabel.centerYAnchor.constraint(
                equalTo: allTaskButton.centerYAnchor, constant: 1),
            countTasksLabel.trailingAnchor.constraint(
                equalTo: allTaskButton.trailingAnchor),
            countTasksLabel.leadingAnchor.constraint(
                equalTo: allTasksLabel.trailingAnchor, constant: 5),
            countTasksLabel.heightAnchor.constraint(
                equalToConstant: 14),
            devidingLineLabel.centerYAnchor.constraint(
                equalTo: allTaskButton.centerYAnchor),
            devidingLineLabel.leadingAnchor.constraint(
                equalTo: allTaskButton.trailingAnchor, constant: 10),
            devidingLineLabel.heightAnchor.constraint(
                equalToConstant: 16),
            devidingLineLabel.widthAnchor.constraint(
                equalToConstant: 2),
            completeTasksButton.topAnchor.constraint(
                equalTo: dateLabel.bottomAnchor, constant: 20),
            completeTasksButton.leadingAnchor.constraint(
                equalTo: devidingLineLabel.trailingAnchor, constant: 10),
            completeTasksLabel.centerYAnchor.constraint(
                equalTo: completeTasksButton.centerYAnchor),
            completeTasksLabel.leadingAnchor.constraint(
                equalTo: completeTasksButton.leadingAnchor),
            countCompleteTasksLabel.centerYAnchor.constraint(
                equalTo: completeTasksButton.centerYAnchor, constant: 1),
            countCompleteTasksLabel.trailingAnchor.constraint(
                equalTo: completeTasksButton.trailingAnchor),
            countCompleteTasksLabel.leadingAnchor.constraint(
                equalTo: completeTasksLabel.trailingAnchor, constant: 5),
            countCompleteTasksLabel.heightAnchor.constraint(
                equalToConstant: 14),
            doTasksButton.topAnchor.constraint(
                equalTo: dateLabel.bottomAnchor, constant: 20),
            doTasksButton.leadingAnchor.constraint(
                equalTo: completeTasksButton.trailingAnchor, constant: 10),
            doTasksLabel.centerYAnchor.constraint(
                equalTo: doTasksButton.centerYAnchor),
            doTasksLabel.leadingAnchor.constraint(
                equalTo: doTasksButton.leadingAnchor),
            countDoTasksLabel.centerYAnchor.constraint(
                equalTo: doTasksButton.centerYAnchor, constant: 1),
            countDoTasksLabel.trailingAnchor.constraint(
                equalTo: doTasksButton.trailingAnchor),
            countDoTasksLabel.leadingAnchor.constraint(
                equalTo: doTasksLabel.trailingAnchor, constant: 5),
            countDoTasksLabel.heightAnchor.constraint(
                equalToConstant: 14)
        ])
    }
    
    func setupLayoutTasksList() {
        backgroundColor = UIColor(red: 249/255, green: 249/255, blue: 249/255, alpha: 0.98)
        addSubview(tasksListTableView)
        
        NSLayoutConstraint.activate([
            tasksListTableView.topAnchor.constraint(
                equalTo: allTaskButton.bottomAnchor, constant: 0),
            tasksListTableView.leadingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 15),
            tasksListTableView.trailingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -15),
            tasksListTableView.bottomAnchor.constraint(
                equalTo: safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
    }
    
    func changeTypeTasks() {
        allTasksLabel.textColor = UIColor(red: 183/255, green: 183/255, blue: 183/255, alpha: 1)
        countTasksLabel.backgroundColor = UIColor(red: 217/255, green: 217/255, blue: 217/255, alpha: 1)
        completeTasksLabel.textColor = UIColor(red: 183/255, green: 183/255, blue: 183/255, alpha: 1)
        countCompleteTasksLabel.backgroundColor = UIColor(red: 217/255, green: 217/255, blue: 217/255, alpha: 1)
        doTasksLabel.textColor = UIColor(red: 183/255, green: 183/255, blue: 183/255, alpha: 1)
        countDoTasksLabel.backgroundColor = UIColor(red: 217/255, green: 217/255, blue: 217/255, alpha: 1)
        
        viewControler?.updateTasksInfo()
        for counter in 0...2 {
            if buttonStatus[counter] == true {
                if counter == 0 {
                    allTasksLabel.textColor = UIColor(red: 49/255, green: 89/255, blue: 235/255, alpha: 1)
                    countTasksLabel.backgroundColor = UIColor(red: 49/255, green: 89/255, blue: 235/255, alpha: 1)
                }
                if counter == 1 {
                    completeTasksLabel.textColor = UIColor(red: 49/255, green: 89/255, blue: 235/255, alpha: 1)
                    countCompleteTasksLabel.backgroundColor = UIColor(red: 49/255, green: 89/255, blue: 235/255, alpha: 1)
                }
                if counter == 2 {
                    doTasksLabel.textColor = UIColor(red: 49/255, green: 89/255, blue: 235/255, alpha: 1)
                    countDoTasksLabel.backgroundColor = UIColor(red: 49/255, green: 89/255, blue: 235/255, alpha: 1)
                }
            }
        }
    }
    
    func setupDate(date: String) {
        dateLabel.text = date
    }
}
