//
//  CoreDataStack.swift
//  Dogs(Wallet)
//
//  Created by Азизбек on 24.08.2020.
//  Copyright © 2020 Azizbek Ismailov. All rights reserved.
//

import UIKit
import CoreData

class CoreDataStack {
    
    static let shared = CoreDataStack()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Dogs_Wallet_")
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
                print("Success")
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func saveAllDogs(lists:[String:[String]] ) {
        let managedContext = persistentContainer.viewContext
        for (index, value) in lists {
            let dog = Dog(context: managedContext)
            dog.breed = index
            dog.like = false
            if !value.isEmpty {
                for index in value {
                    let subbreed =  Subbreed(context: managedContext)
                    subbreed.name = index
                    dog.addToRelationship(subbreed)
                }
            }
            saveContext()
        }
    }
    
//    func fetchLists(complition: @escaping (_ lists: [CategoryList]) -> Void) {
//        let managedContext = taskPersistentContainer.viewContext
//        let fetchRequest = NSFetchRequest<CategoryList>(entityName: "CategoryList")
//        do {
//            let categorys = try managedContext.fetch(fetchRequest)
//            complition(categorys)
//        } catch let error {
//            print(error.localizedDescription)
//        }
//    }
    
//    func fetchTasks(category: String? = nil, complition:@escaping (_ tasks: [Task]) -> Void) {
//        let managedContext = taskPersistentContainer.viewContext
//        let fetchRequest = NSFetchRequest<Task>(entityName: "Task")
//        let sortDiscriptor = NSSortDescriptor(key: #keyPath(Task.date), ascending: false)
//        let sortDiscriptor2 = NSSortDescriptor(key: #keyPath(Task.category), ascending: true)
//        fetchRequest.sortDescriptors = [sortDiscriptor, sortDiscriptor2]
//        do {
//            let tasks = try managedContext.fetch(fetchRequest)
//            if category == nil {
//                complition(tasks)
//
//            } else {
//                var taskFromSomeCategory = [Task]()
//                for task in tasks where task.category?.name == category {
//                    taskFromSomeCategory.append(task)
//                }
//                complition(taskFromSomeCategory)
//            }
//
//        } catch let error {
//            print(error.localizedDescription)
//        }
//    }
    
//    func updateStatus(task: Task, value: Bool) {
//        fetchTasks { (allTask) in
//            for oneTask in allTask where oneTask === task {
//                oneTask.setValue(value, forKey: "done")
//
//                do {
//                    try oneTask.managedObjectContext?.save()
//                    print("Удачное изменение")
//                } catch  let error {
//                    print(error.localizedDescription)
//                }
//
//            }
//        }
//    }
//    func deleteTask(task: Task) {
//        let managedContext = taskPersistentContainer.viewContext
//        managedContext.delete(task)
//
//        do {
//            try managedContext.save()
//            print("Удачное удаление")
//        } catch let error {
//            print(error.localizedDescription)
//        }
//    }
}
