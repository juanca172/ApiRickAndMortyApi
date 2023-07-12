//
//  coreDataStack.swift
//  ApiRickAndMortyNetworking
//
//  Created by Juan Camilo Fonseca Gomez on 6/07/23.
//

import Foundation
import CoreData

protocol CoreDataStackProtocol {
    
    var managedContext: NSManagedObjectContext { get }
    func save()
    
}
 
class CoreDataStack: CoreDataStackProtocol {
    
    static var sharedCoreData: CoreDataStackProtocol = CoreDataStack()
    private let container: NSPersistentContainer!
    lazy var managedContext = container.viewContext
    
    init() {
        container = NSPersistentContainer(name: "RickAndMortyStorage")
        setUpCoreData()
        save()
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
    
    func save() {
        saveContext()
    }
    
    
    // MARK: - Core Data Saving support
    func saveContext() {
        if managedContext.hasChanges {
            do {
                try managedContext.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
}
