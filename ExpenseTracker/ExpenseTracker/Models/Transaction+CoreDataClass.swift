//
//  Transaction+CoreDataClass.swift
//  ExpenseTracker
//
//  Created by Kyzu on 26.12.22.
//
//

import Foundation
import CoreData

@objc(Transaction)
public class Transaction: NSManagedObject {
    convenience init() {
        self.init(entity: CoreDataManager.shared.entityForName(entityName: "Transaction"), insertInto: CoreDataManager.shared.context)
    }
}
