//
//  Wallet+CoreDataClass.swift
//  ExpenseTracker
//
//  Created by Kyzu on 25.12.22.
//
//

import Foundation
import CoreData

@objc(Wallet)
public class Wallet: NSManagedObject {
    convenience init() {
        self.init(entity: CoreDataManager.shared.entityForName(entityName: "Wallet"), insertInto: CoreDataManager.shared.context)
    }
}
