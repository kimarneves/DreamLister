//
//  Item+CoreDataClass.swift
//  DreamLister
//
//  Created by Kimar Arakaki Neves on 2016-11-24.
//  Copyright © 2016 Kimar. All rights reserved.
//

import Foundation
import CoreData

@objc(Item)
public class Item: NSManagedObject {

    public override func awakeFromInsert() {
        super.awakeFromInsert()
        
        created = NSDate()
    }
}
