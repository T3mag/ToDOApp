//
//  dummyJsonStructure.swift
//  ToDoList
//
//  Created by Артур Миннушин on 05.09.2024.
//

import Foundation

struct DummyJson: Codable {
    let todos: [todos]
    struct todos: Codable {
        let id: Int
        let todo: String
        let completed: Bool
    }
}
