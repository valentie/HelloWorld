//
//  CDFavorite+CoreDataProperties.swift
//  
//
//  Created by creativeme on 17/2/2563 BE.
//
//

import Foundation
import CoreData


extension CDFavorite {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDFavorite> {
        return NSFetchRequest<CDFavorite>(entityName: "CDFavorite")
    }

    @NSManaged public var code: String?
    @NSManaged public var flagPath: String?

}
