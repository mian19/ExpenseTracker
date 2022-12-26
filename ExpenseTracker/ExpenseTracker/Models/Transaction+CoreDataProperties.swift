//
//  Transaction+CoreDataProperties.swift
//  ExpenseTracker
//
//  Created by Kyzu on 26.12.22.
//
//

import Foundation
import CoreData


extension Transaction {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Transaction> {
        return NSFetchRequest<Transaction>(entityName: "Transaction")
    }

    @NSManaged public var amount: Int64
    @NSManaged public var category: String
    @NSManaged public var date: Date
    @NSManaged public var transactionDay: TransactionDay

}

extension Transaction : Identifiable {

}
