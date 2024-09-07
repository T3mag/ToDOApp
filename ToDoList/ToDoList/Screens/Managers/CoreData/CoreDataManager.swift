//
//  CoreDataManager.swift
//  ToDoList
//
//  Created by Артур Миннушин on 03.09.2024.
//

import Foundation
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    let backgroundQueue = DispatchQueue.global()
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    var backgroundContext: NSManagedObjectContext {
        return persistentContainer.newBackgroundContext()
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoreData")
        container.loadPersistentStores(completionHandler: {( _, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
        
    }()
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try viewContext.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func saveBackgroundContext(context: NSManagedObjectContext) {
        do {
            try context.save()
            viewContext.performAndWait {
                do {
                    try viewContext.save()
                } catch {
                    print("Error when save viewContext: \(error)")
                }
            }
        } catch {
            print("Error when save backgroundContext: \(error)")
        }
    }
    
    func addTasks(taskName: String, taskDescription: String, taskStatus: Bool, taskId: Int?) {
        let context = backgroundContext
        return backgroundContext.perform {
            let task = Tasks(context: context)
            task.taskID = Int64(taskId ?? 10000000)
            task.taskName = taskName
            task.taskDescription = taskDescription
            task.taskStatus = taskStatus
            task.taskDate = Date()
            print("Добавлена заметка с id: \(task.taskID)")
            self.saveBackgroundContext(context: context)
        }
    }
    
    func asyncObtaineSavedTasks(completion: @escaping([Tasks]) -> Void) {
        backgroundQueue.async {
            let videoFetchRequest = Tasks.fetchRequest()
            let sortDescriptors = NSSortDescriptor(key: "taskDate", ascending: true)
            videoFetchRequest.sortDescriptors = [sortDescriptors]
            let result = try? self.viewContext.fetch(videoFetchRequest)
            completion(result ?? [])
        }
    }
    
    func obtaineSavedTasks() -> [Tasks] {
        let videoFetchRequest = Tasks.fetchRequest()
        let sortDescriptors = NSSortDescriptor(key: "taskDate", ascending: true)
        videoFetchRequest.sortDescriptors = [sortDescriptors]
        let result = try? self.viewContext.fetch(videoFetchRequest)
        return result ?? []
    }
    
    func seporateSavedTasksStatus() -> ([Tasks], [Tasks]) {
        let videoFetchRequest = Tasks.fetchRequest()
        let sortDescriptors = NSSortDescriptor(key: "taskStatus", ascending: false)
        videoFetchRequest.sortDescriptors = [sortDescriptors]
        let tasks = try? self.viewContext.fetch(videoFetchRequest)
        var border = 0
        for i in 0..<tasks!.count {
            if !tasks![i].taskStatus {
                border = i
                break
            }
        }
        return (Array(tasks![0..<border]), Array(tasks![border..<tasks!.count]))
    }
    
    func deleteTaskById(taskId: Int64) {
        let context = backgroundContext
        return backgroundContext.perform {
            guard let task = self.obtaineSavedTasks().first(where: {$0.taskID == taskId}) else {
                fatalError()
            }
            let backgroundTask = context.object(with: task.objectID)
            context.delete(backgroundTask)
            print("Удалена заметка с iD: \(taskId)")
            self.saveBackgroundContext(context: context)
        }
    }
}
