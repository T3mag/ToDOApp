//
//  Tasks+CoreDataProperties.swift
//  ToDoList
//
//  Created by Артур Миннушин on 05.09.2024.
//
//

import Foundation
import CoreData


extension Tasks {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Tasks> {
        return NSFetchRequest<Tasks>(entityName: "Tasks")
    }

    @NSManaged public var taskDate: Date?
    @NSManaged public var taskDescription: String?
    @NSManaged public var taskID: Int64
    @NSManaged public var taskName: String?
    @NSManaged public var taskStatus: Bool

}

extension Tasks : Identifiable {

}
