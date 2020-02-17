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
    
    public func checkFavorite(name: String) -> Observable<Bool> {
        let context =  coreDataStack.context
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "CDFavorite")
        request.predicate = NSPredicate(format: "code = %@",name)
        do {
            let result = try context.fetch(request)
            if result.isEmpty {
                return Observable.just(false)
            }else{
                return Observable.just(true)
            }
        } catch {
            print("Failed")
            return Observable.just(false)
        }
    }
    
    public func fetchFavorite() -> Observable<[Favorite]> {
        let context =  coreDataStack.context
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "CDFavorite")
        request.returnsObjectsAsFaults = false
        
        do {
            let result = try context.fetch(request)
            
            var lists = [Favorite]()
            for data in result as! [CDFavorite] {
                let content = Favorite(code: data.code ?? "", flagPath: data.flagPath ?? "")
                lists.append(content)
            }
            
            return Observable.just(lists)
        } catch {
            print("Failed")
            return Observable.just([])
        }
    }
    
    public func triggleFavorite(object: Favorite) -> Bool {
        let context = coreDataStack.context
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "CDFavorite")
        request.predicate = NSPredicate(format: "code = %@",object.code)
        var isFavorite = false
        do {
            let result = try context.fetch(request)
            if result.isEmpty {
                let newFavorite = CDFavorite(context: context)
                newFavorite.code = object.code
                newFavorite.flagPath = object.flagPath
                isFavorite = true
            }else{
                for obj in result as! [NSManagedObject] {
                    context.delete(obj)
                }
            }
            
            try context.save()
        } catch {
            print ("Failed Triggle")
        }
        
        return isFavorite
    }
}
