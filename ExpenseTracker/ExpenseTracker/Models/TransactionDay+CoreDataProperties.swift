//
//  TransactionDay+CoreDataProperties.swift
//  ExpenseTracker
//
//  Created by Kyzu on 26.12.22.
//
//

import Foundation
import CoreData


extension TransactionDay {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TransactionDay> {
        return NSFetchRequest<TransactionDay>(entityName: "TransactionDay")
    }

    @NSManaged public var day: String
    @NSManaged public var transactions: NSSet

}

// MARK: Generated accessors for transactions
extension TransactionDay {

    @objc(addTransactionsObject:)
    @NSManaged public func addToTransactions(_ value: Transaction)

    @objc(removeTransactionsObject:)
    @NSManaged public func removeFromTransactions(_ value: Transaction)

    @objc(addTransactions:)
    @NSManaged public func addToTransactions(_ values: NSSet)

    @objc(removeTransactions:)
    @NSManaged public func removeFromTransactions(_ values: NSSet)

}

extension TransactionDay : Identifiable {

}
