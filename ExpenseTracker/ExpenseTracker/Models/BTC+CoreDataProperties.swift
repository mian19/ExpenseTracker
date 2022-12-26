//
//  BTC+CoreDataProperties.swift
//  ExpenseTracker
//
//  Created by Kyzu on 25.12.22.
//
//

import Foundation
import CoreData


extension BTC {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BTC> {
        return NSFetchRequest<BTC>(entityName: "BTC")
    }

    @NSManaged public var inDollars: String?
    @NSManaged public var updatedDate: Date?

}

extension BTC : Identifiable {

}
