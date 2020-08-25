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
    
    lazy var allDogsPersistentContainer: NSPersistentContainer = {
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
        let context = allDogsPersistentContainer.viewContext
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
        let managedContext = allDogsPersistentContainer.viewContext
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
    
    func fetchLists() -> [Dog] {
        let managedContext = allDogsPersistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Dog>(entityName: "Dog")
        do {
            let dogs = try managedContext.fetch(fetchRequest)
            return dogs
        } catch let error {
            print(error.localizedDescription)
        }
        return [Dog]()
    }
    
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
