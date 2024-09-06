//
//  NetworkManager.swift
//  ToDoList
//
//  Created by Артур Миннушин on 03.09.2024.
//


import UIKit
import Combine

class NetworkManager {
    
    static let shared = NetworkManager(with: .default)
    private var coreData = CoreDataManager.shared
    private var tasks: [DummyJson.todos]
    private let session: URLSession
    @Published var flagObtainedAllStartTasks: Bool = true
    private lazy var jsonDecoder: JSONDecoder = {
        JSONDecoder()
    }()
    
    init(with configuration: URLSessionConfiguration) {
        session = URLSession(configuration: configuration)
        tasks = []
    }
    
    func getStartsTasks() async throws -> DummyJson {
        let urlString = "https://dummyjson.com/todos"
        guard let url = URL(string: urlString.addingPercentEncoding(
            withAllowedCharacters: .urlQueryAllowed)!)
        else { fatalError() }
        var urlRequset = URLRequest(url: url)
        urlRequset.httpMethod = "GET"
        let responseData = try await session.data(for: urlRequset)
        return try jsonDecoder.decode(DummyJson.self, from: responseData.0)
    }
    
    func obtainStartTasks() {
        flagObtainedAllStartTasks = false
        Task {
            do {
                let data = try await getStartsTasks()
                print(data.todos.count)
                tasks = data.todos
                for i in 0..<tasks.count {
                    self.coreData.addTasks(taskName: self.tasks[i].todo, taskDescription: self.tasks[i].todo, taskStatus: self.tasks[i].completed, taskId: self.tasks[i].id)
                }
                while data.todos.count != coreData.obtaineSavedTasks().count {}
                flagObtainedAllStartTasks = true
                
            } catch {
                print("Error: \(error)")
            }
        }
    }
    
    func getTasks() -> [DummyJson.todos] {
        return tasks
    }
}
