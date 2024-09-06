//
//  TaskScreenTableViewCell.swift
//  ToDoList
//
//  Created by Артур Миннушин on 03.09.2024.
//

import UIKit

class TaskScreenTableViewCell: UITableViewCell {
    
    lazy var taskNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.textColor = .black
        return label
    }()
    
    lazy var taskDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.textColor = UIColor(red: 165/255, green: 165/255, blue: 165/255, alpha: 1)
        return label
    }()
    
    lazy var seporationLineLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        return label
    }()
    
    lazy var taskDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        label.textColor = UIColor(red: 165/255, green: 165/255, blue: 165/255, alpha: 1)
        return label
    }()
    
    lazy var checkMarkButton: UIButton = {
        let buttton = UIButton(type: .custom)
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 15, weight: .semibold, scale: .small)
        buttton.translatesAutoresizingMaskIntoConstraints = false
        buttton.setImage(UIImage(systemName: "checkmark", withConfiguration: imageConfig), for: .normal)
        buttton.backgroundColor = UIColor(red: 9/255, green: 99/255, blue: 237/255, alpha: 1)
        buttton.tintColor = .white
        buttton.layer.cornerRadius = 12
        return buttton
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    func setupLayout() {
        backgroundColor = .white
        layer.cornerRadius = 10
        addSubview(taskNameLabel)
        addSubview(taskDescriptionLabel)
        addSubview(seporationLineLabel)
        addSubview(taskDateLabel)
        addSubview(checkMarkButton)
        
        NSLayoutConstraint.activate([
            taskNameLabel.topAnchor.constraint(
                equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            taskNameLabel.leadingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            checkMarkButton.topAnchor.constraint(
                equalTo: taskNameLabel.topAnchor, constant: 5),
            checkMarkButton.trailingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            checkMarkButton.widthAnchor.constraint(
                equalToConstant: 25),
            checkMarkButton.heightAnchor.constraint(
                equalToConstant: 25),
            taskDescriptionLabel.topAnchor.constraint(
                equalTo: taskNameLabel.bottomAnchor, constant: 10),
            taskDescriptionLabel.leadingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            seporationLineLabel.topAnchor.constraint(
                equalTo: taskDescriptionLabel.bottomAnchor, constant: 10),
            seporationLineLabel.leadingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            seporationLineLabel.trailingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            seporationLineLabel.heightAnchor.constraint(
                equalToConstant: 2),
            taskDateLabel.topAnchor.constraint(
                equalTo: seporationLineLabel.bottomAnchor, constant: 20),
            taskDateLabel.leadingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            taskDateLabel.bottomAnchor.constraint(
                equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
    
    func setupTaskInfo(nameTask: String, descriptionTask: String, dateTask: String) {
        taskNameLabel.text = nameTask
        taskDescriptionLabel.text = descriptionTask
        taskDateLabel.text = dateTask
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
