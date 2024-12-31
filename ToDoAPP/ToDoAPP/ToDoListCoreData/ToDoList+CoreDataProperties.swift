//
//  ToDoList+CoreDataProperties.swift
//  ToDoAPP
//
//  Created by Loyltwo3ks on 04/11/24.
//
//

import Foundation
import CoreData


extension ToDoList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ToDoList> {
        return NSFetchRequest<ToDoList>(entityName: "ToDoList")
    }

    @NSManaged public var title: String?
    @NSManaged public var date: String?
    @NSManaged public var status: String?
    @NSManaged public var priority: String?
    @NSManaged public var describe: String?
    @NSManaged public var remark: String?

}

extension ToDoList : Identifiable {

}
