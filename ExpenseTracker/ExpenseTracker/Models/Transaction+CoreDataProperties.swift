//
//  Transaction+CoreDataProperties.swift
//  ExpenseTracker
//
//  Created by Kyzu on 25.12.22.
//
//

import Foundation
import CoreData


extension Transaction {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Transaction> {
        return NSFetchRequest<Transaction>(entityName: "Transaction")
    }

    @NSManaged public var amount: Double
    @NSManaged public var category: String?
    @NSManaged public var date: Date?
    @NSManaged public var direction: String?

}

extension Transaction : Identifiable {

}
