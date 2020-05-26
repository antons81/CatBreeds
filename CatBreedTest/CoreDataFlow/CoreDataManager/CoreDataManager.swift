//
//  CoreDataManager.swift
//  CatBreedTest
//
//  Created by Anton Stremovskiy on 21.05.2020.
//  Copyright © 2020 Anton Stremovskiy. All rights reserved.
//

import Foundation
import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager()
    private init() {}
    
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CatBreeds")
        
        container.loadPersistentStores(completionHandler: { (description, error) in
            
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
            
            description.shouldMigrateStoreAutomatically = true
            description.shouldInferMappingModelAutomatically = true
            container.persistentStoreDescriptions =  [description]
        })
        return container
    }()
    
    
    // MARK: - Core Data Saving support
    
    func saveContext (with context: NSManagedObjectContext, completion: (() -> Void)?) {
        if context.hasChanges {
            do {
                try context.save()
                completion?()
            } catch {
                let nserror = error as NSError
                print("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    
    // MARK: - Get Default Context
    
    var defaultContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    // MARK: - Create Entity
    
    func createEntity(with entity: ManagedEntities) -> NSManagedObject? {
        if let entity = NSEntityDescription.entity(forEntityName: entity.name,
                                                   in: defaultContext) {
            
            let model = NSManagedObject(entity: entity,
                                        insertInto: defaultContext)
            return model
        }
        return nil
    }
    
    func deleteAllData(_ entity: ManagedEntities, completion: (() -> Void)?) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
        fetchRequest.entity = NSEntityDescription.entity(forEntityName: entity.name, in: defaultContext)
        fetchRequest.includesPropertyValues = false
        let context = defaultContext
        
        do {
            let results = try context.fetch(fetchRequest) as! [NSManagedObject]
            for result in results {
                context.delete(result)
            }
            try context.save()
            completion?()
        } catch {
            completion?()
            print("fetch error -\(error.localizedDescription)")
        }
    }
    
    
    func isExist(for entity: ManagedEntities, id: String) -> Bool {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity.name)
        fetchRequest.predicate = NSPredicate(format: "id = %@", id)

        do {
            let res = try defaultContext.fetch(fetchRequest)
            return res.count > 0
        } catch let error {
            print("could not fetch data, error:", error.localizedDescription)
            return false
        }
    }
    
    
    // MARK: - Fetch Data from Entity
    
    func fetchData<T: NSManagedObject>(entity: ManagedEntities, completion: (([T]) -> Void)?) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity.name)
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)]
        
        do {
            let result = try defaultContext.fetch(fetchRequest)
            if let result = result as? [T] {
                completion?(result)
            }
        } catch let error {
            print("Could not fetch data from entity \(entity.name) error: ", error.localizedDescription)
        }
    }
}
