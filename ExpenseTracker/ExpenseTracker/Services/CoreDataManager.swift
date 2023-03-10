//
//  CoreDataManager.swift
//  ExpenseTracker
//
//  Created by Kyzu on 14.12.22.
//

import Foundation
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    
    private init() {}
    
    lazy var context: NSManagedObjectContext = { persistentContainer.viewContext }()
    
    func entityForName(entityName: String) -> NSEntityDescription {
        return NSEntityDescription.entity(forEntityName: entityName, in: context)!
    }
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ExpenseTracker")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - fetching data
    func fetchBTC() -> [BTC] {
        var btcData = [BTC]()
        do {
            btcData = try context.fetch(BTC.fetchRequest())
        } catch {
            print("couldnt fetch")
        }
        return btcData
    }
    
    func fetchCashInWallet() -> [Wallet] {
        var walletData = [Wallet]()
        do {
            walletData = try context.fetch(Wallet.fetchRequest())
        } catch {
            print("couldnt fetch")
        }
        return walletData
    }
    
    func fetchTransactions() -> [Transaction] {
        var transData = [Transaction]()
        do {
            transData = try context.fetch(Transaction.fetchRequest())
        } catch {
            print("couldnt fetch")
        }
        return transData
    }
    
    func fetchTransactionDay(day: String) -> [TransactionDay] {
        var transData = [TransactionDay]()
        do {
            let request = TransactionDay.fetchRequest()
            let filter = day
            let commitPredicate = NSPredicate(format: "day == %@", filter)
            request.predicate = commitPredicate
            transData = try context.fetch(request)
            
        } catch {
            print("couldnt fetch")
        }
        return transData
    }
 
    // MARK: - Core Data Saving support
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
}
