//
//  TaskDetailsScreenView.swift
//  ToDoList
//
//  Created by Артур Миннушин on 06.09.2024.
//

import UIKit

class TaskDetailsScreenView: UIView {
    
    private var isCreating: Bool?
    private var viewController: TaskDetailsScreenViewController?
    private var task: Tasks?
    private lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    private lazy var nameTaskLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.text = "Название задачи"
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        return label
    }()
    private lazy var nameTaskTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.keyboardType = .default
        textField.backgroundColor = .white
        textField.placeholder = "  Название"
        textField.layer.cornerRadius = 5
        textField.textColor = UIColor(red: 165/255, green: 165/255, blue: 165/255, alpha: 1)
        return textField
    }()
    private lazy var descriptionTaskLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.text = "Описание задачи"
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        return label
    }()
    private lazy var descriptionTaskTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.keyboardType = .default
        textField.backgroundColor = .white
        textField.placeholder = "  Описание"
        textField.layer.cornerRadius = 5
        textField.textColor = UIColor(red: 165/255, green: 165/255, blue: 165/255, alpha: 1)
        return textField
    }()
    private lazy var seporationLineLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .lightGray
        return label
    }()
    private lazy var dateTaskLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.textColor = UIColor(red: 165/255, green: 165/255, blue: 165/255, alpha: 1)
        return label
    }()
    private lazy var saveOrCreateTaskButton: UIButton = {
        let button = UIButton()
        let action = UIAction { [weak self] _ in
            self?.saveOrCreateTask()
        }
        button.addAction(action, for: .touchUpInside)
        button.setTitle("  Сохранить  ", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        button.backgroundColor = UIColor(red: 227/255, green: 235/255, blue: 249/255, alpha: 1)
        button.setTitleColor(UIColor(red: 75/255, green: 124/255, blue: 231/255, alpha: 1), for: .normal)
        button.layer.cornerRadius = 15
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupForCreateTask() {
        isCreating = true
        headerLabel.text = "Создание задачи"
        nameTaskTextField.text = ""
        descriptionTaskTextField.text = ""
        dateTaskLabel.text = viewController?.getDateString(date: Date())
        saveOrCreateTaskButton.setTitle("  Создать задачу  ", for: .normal)
    }
    
    func setupForEditingTask(task: Tasks) {
        isCreating = false
        self.task = task
        headerLabel.text = "Редактирование задачи"
        nameTaskTextField.text = task.taskName
        descriptionTaskTextField.text = task.taskDescription
        dateTaskLabel.text = viewController?.getDateString(date: task.taskDate!)
        saveOrCreateTaskButton.setTitle("  Сохранить изменения  ", for: .normal)
    }
    
    func setupViewController(viewController: TaskDetailsScreenViewController) {
        self.viewController = viewController
    }
    
    func saveOrCreateTask() {
        if isCreating! {
            viewController?.createTaskInfo(taskname: nameTaskTextField.text ?? " Новая задача ",
                                           taskDescription: descriptionTaskTextField.text ?? "",
                                           taskStatus: false)
        } else {
            
            viewController?.updateTaskInfo(taskname: nameTaskTextField.text ?? " Новая задача ",
                                           taskDescription: descriptionTaskTextField.text ?? "",
                                           taskStatus: task?.taskStatus ?? false, taskId: task!.taskID)
        }
    }
    
    func setupLayout() {
        addSubview(headerLabel)
        addSubview(nameTaskLabel)
        addSubview(nameTaskTextField)
        addSubview(descriptionTaskLabel)
        addSubview(descriptionTaskTextField)
        addSubview(seporationLineLabel)
        addSubview(dateTaskLabel)
        addSubview(saveOrCreateTaskButton)
        backgroundColor = UIColor(red: 249/255, green: 249/255, blue: 249/255, alpha: 0.98)
        
        NSLayoutConstraint.activate([
            headerLabel.centerXAnchor.constraint(
                equalTo: safeAreaLayoutGuide.centerXAnchor),
            headerLabel.topAnchor.constraint(
                equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            nameTaskLabel.topAnchor.constraint(
                equalTo: headerLabel.bottomAnchor, constant: 20),
            nameTaskLabel.leadingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            nameTaskTextField.topAnchor.constraint(
                equalTo: nameTaskLabel.bottomAnchor, constant: 5),
            nameTaskTextField.leadingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            nameTaskTextField.trailingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            nameTaskTextField.heightAnchor.constraint(
                equalToConstant: 20),
            descriptionTaskLabel.topAnchor.constraint(
                equalTo: nameTaskTextField.bottomAnchor, constant: 10),
            descriptionTaskLabel.leadingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            descriptionTaskTextField.topAnchor.constraint(
                equalTo: descriptionTaskLabel.bottomAnchor, constant: 5),
            descriptionTaskTextField.leadingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            descriptionTaskTextField.trailingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            descriptionTaskTextField.heightAnchor.constraint(
                equalToConstant: 20),
            seporationLineLabel.topAnchor.constraint(
                equalTo: descriptionTaskTextField.bottomAnchor, constant: 20),
            seporationLineLabel.leadingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            seporationLineLabel.trailingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            seporationLineLabel.heightAnchor.constraint(
                equalToConstant: 2),
            dateTaskLabel.topAnchor.constraint(
                equalTo: seporationLineLabel.bottomAnchor, constant: 20),
            dateTaskLabel.centerXAnchor.constraint(
                equalTo: safeAreaLayoutGuide.centerXAnchor),
            saveOrCreateTaskButton.bottomAnchor.constraint(
                equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
            saveOrCreateTaskButton.centerXAnchor.constraint(
                equalTo: safeAreaLayoutGuide.centerXAnchor),
            saveOrCreateTaskButton.heightAnchor.constraint(
                equalToConstant: 30)
        ])
    }
}
