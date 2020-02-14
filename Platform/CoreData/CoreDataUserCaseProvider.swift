//
//  CoreDataUserCaseProvider.swift
//  Platform
//
//  Created by creativeme on 13/2/2563 BE.
//  Copyright © 2563 creativeme. All rights reserved.
//

import Foundation
import Domain
import RxSwift

public final class CoreDataUserCaseProvider: Domain.FavoriteUseCase {
    private let coreDataStack: CoreDataStack
    
    public init() {
        coreDataStack = CoreDataStack()
    }
    
//    class func getKitchens() -> [KitchenInfo] {
//      let appDelegate = UIApplication.shared.delegate as! AppDelegate
//      let context = appDelegate.persistentContainer.viewContext
//      let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Kitchen")
//      do {
//        let result = try context.fetch(request)
//        return result as? [KitchenInfo] ?? []
//      } catch {
//        print("Failed")
//        return []
//      }
//    }
    
    public func fetchFavorite() -> Observable<Void> {
//        Observable<[Favorite]> {
        return Observable.just(Void())
    }
    
    public func addFavortie(object: Favorite) -> Observable<Void> {
        return Observable.just(Void())
    }
    
    public func deleteFavorite(object: Favorite) -> Observable<Void> {
        return Observable.just(Void())
    }
}
