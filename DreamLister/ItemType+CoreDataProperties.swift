//
//  ItemType+CoreDataProperties.swift
//  DreamLister
//
//  Created by Kimar Arakaki Neves on 2016-11-24.
//  Copyright © 2016 Kimar. All rights reserved.
//

import Foundation
import CoreData


extension ItemType {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ItemType> {
        return NSFetchRequest<ItemType>(entityName: "ItemType");
    }

    @NSManaged public var type: String?
    @NSManaged public var toItem: Item?

}
