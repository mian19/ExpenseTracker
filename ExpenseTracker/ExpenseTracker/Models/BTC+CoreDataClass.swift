//
//  BTC+CoreDataClass.swift
//  ExpenseTracker
//
//  Created by Kyzu on 25.12.22.
//
//

import Foundation
import CoreData

@objc(BTC)
public class BTC: NSManagedObject {
    convenience init() {
        self.init(entity: CoreDataManager.shared.entityForName(entityName: "BTC"), insertInto: CoreDataManager.shared.context)
    }
    
}
