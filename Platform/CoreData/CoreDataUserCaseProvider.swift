//
//  CoreDataUserCaseProvider.swift
//  Platform
//
//  Created by creativeme on 13/2/2563 BE.
//  Copyright © 2563 creativeme. All rights reserved.
//

import Foundation
import Domain
import CoreData
import RxSwift

public final class CoreDataUserCaseProvider: Domain.FavoriteUseCase {
    
    private let coreDataStack: CoreDataStack
    public static var instance = CoreDataUserCaseProvider()
    
    private init() {
        coreDataStack = CoreDataStack()
    }
    
//    public func checkFavorite(object: String) -> Observable<Bool> {
//        <#code#>
//    }
    
    public func fetchFavorite() -> Observable<[Favorite]> {
        let context = persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "CDFavorite")
        do {
          let result = try context.fetch(request)
          return Observable.just(result as? [Favorite] ?? [])
        } catch {
          print("Failed")
            return Observable.just([])
        }
    }
    
    public func addFavortie(object: Favorite) -> Observable<Void> {
        let context = persistentContainer.viewContext
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy

        let newFavorite = CDFavorite(context: context)
        newFavorite.code = object.code
        
        do {
          try context.save()
        } catch {
          print("Failed Add")
        }
        return Observable.just(Void())
    }
    
    public func deleteFavorite(object: Favorite) -> Observable<Void> {
        let context = persistentContainer.viewContext
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy

        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "CDFavorite")
        request.predicate = NSPredicate(format: "code == \(object.code)")
        
        do {
          let result = try context.fetch(request)
          for obj in result as! [NSManagedObject] {
            context.delete(obj)
          }
          
          try context.save()
        } catch {
          print ("Failed Delete")
        }
        
        return Observable.just(Void())
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Model")
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
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
