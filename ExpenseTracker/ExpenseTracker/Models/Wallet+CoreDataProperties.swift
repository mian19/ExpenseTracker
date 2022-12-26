//
//  Wallet+CoreDataProperties.swift
//  ExpenseTracker
//
//  Created by Kyzu on 25.12.22.
//
//

import Foundation
import CoreData


extension Wallet {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Wallet> {
        return NSFetchRequest<Wallet>(entityName: "Wallet")
    }

    @NSManaged public var cash: Int64

}

extension Wallet : Identifiable {

}
