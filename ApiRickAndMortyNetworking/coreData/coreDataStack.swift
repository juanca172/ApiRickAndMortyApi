//
//  coreDataStack.swift
//  ApiRickAndMortyNetworking
//
//  Created by Juan Camilo Fonseca Gomez on 6/07/23.
//

import Foundation
import CoreData

class CoreDataStack {
    
    private let container: NSPersistentContainer!
    lazy var managedContex = container.viewContext
    
    init() {
        container = NSPersistentContainer(name: "Character")
        setUpCoreData()
        saveContext()
    }
    
    
    private func setUpCoreData() {
        container.loadPersistentStores { _, error in
            if let error = error {
                print("Error loading store \(error)")
                return
            }
            print("Database ready!")
        }
    }
    
    // MARK: - Core Data Saving support
    func saveContext() {
        let context = container.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
}
