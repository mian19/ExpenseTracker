//
//  TransactionDay+CoreDataClass.swift
//  ExpenseTracker
//
//  Created by Kyzu on 26.12.22.
//
//

import Foundation
import CoreData

@objc(TransactionDay)
public class TransactionDay: NSManagedObject {
    convenience init() {
        self.init(entity: CoreDataManager.shared.entityForName(entityName: "TransactionDay"), insertInto: CoreDataManager.shared.context)
    }
}
