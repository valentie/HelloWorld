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
    
    public func fetchFavorite() -> Observable<[String]> {
        let context =  coreDataStack.context
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "CDFavorite")
        
        do {
          let result = try context.fetch(request)
          return Observable.just(result as? [String] ?? [])
        } catch {
          print("Failed")
            return Observable.just([])
        }
    }
    
    public func addFavortie(code: String) -> Observable<Void> {
        let context = coreDataStack.context
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy

        let newFavorite = CDFavorite(context: context)
        newFavorite.code = code
        
        do {
          try context.save()
        } catch {
          print("Failed Add")
        }
        return Observable.just(Void())
    }
    
    public func deleteFavorite(code: String) -> Observable<Void> {
        let context = coreDataStack.context
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy

        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "CDFavorite")
        request.predicate = NSPredicate(format: "code == \(code)")
        
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
}
