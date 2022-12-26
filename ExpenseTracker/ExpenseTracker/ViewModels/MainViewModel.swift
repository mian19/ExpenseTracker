//
//  MainViewModel.swift
//  ExpenseTracker
//
//  Created by Kyzu on 5.12.22.
//

import Foundation
import CoreData

class MainViewModel {
    
    var managedWallet: Wallet!
    var oldBTC = CoreDataManager.shared.fetchBTC()
    var transactions = CoreDataManager.shared.fetchTransactions()
    var btcCourse = Dynamic("Loading...")
    var myWallet = Dynamic(0)
    
    func fetchBTC() {
        if oldBTC.count == 0 || (oldBTC.count != 0 && (Date.differenceInDays(from: oldBTC[0].updatedDate!, to: Date.localDate())) != 0) {
            getFreshBTC()
        } else {
            setBTCCourse()
        }
    }
    
    private func getFreshBTC() {
        NetworkManager().getBTC { [weak self] (result) in
            switch result {
            case .success(let result):
                let freshBTC = BTC()
                freshBTC.updatedDate = Date.localDate()
                freshBTC.inDollars = result.bpi.usd.rate
                if self?.oldBTC == [] {
                    self?.oldBTC.append(freshBTC)
                } else {
                    self?.oldBTC[0].setValue(Date.localDate(), forKey: "updatedDate")
                    self?.oldBTC[0].setValue(result.bpi.usd.rate, forKey: "inDollars")
                }
                self?.setBTCCourse()
                CoreDataManager.shared.saveContext()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func setBTCCourse() {
        btcCourse.value = "1 BTC = \(oldBTC[0].inDollars ?? "") USD\nupdated: \(oldBTC[0].updatedDate?.dateForBTC() ?? "")"
    }
    
    func getMyWallet() {
        let money = CoreDataManager.shared.fetchCashInWallet()
        if !money.isEmpty {
            myWallet.value = Int(money[0].cash)
            managedWallet = money[0]
        } else {
            managedWallet = Wallet()
        }
    }
    
    func addMoney(sum: Int) {
        
        let trans = Transaction()
        trans.amount = Int64(sum)
        trans.category = "Income"
        trans.date = Date.localDate()
        
        addTransaction(transaction: trans)
        
        myWallet.value += sum
        self.managedWallet.setValue(myWallet.value, forKey: "cash")
        CoreDataManager.shared.saveContext()
    }
    
    func addTransaction(transaction: Transaction) {
        var transDay: TransactionDay!
        let days = CoreDataManager.shared.fetchTransactionDay(day: Date.dateToString(date: Date.localDate()))
        if days.count > 0 {
            
            transDay = days[0]
        }
        
        if days.count == 0 {
            
            let newDay = TransactionDay()
            newDay.day = Date.dateToString(date: Date.localDate())
            transDay = newDay
        }
        
        transaction.transactionDay = transDay
    }
    
    var fetchResultController: NSFetchedResultsController<NSFetchRequestResult> = {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Transaction")
        do {
            let results = try CoreDataManager.shared.context.fetch(fetchRequest)
        } catch {
            print(error)
        }
        fetchRequest.sortDescriptors = [ NSSortDescriptor(key: "date", ascending: false)]
        fetchRequest.fetchBatchSize = 20
        let fetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataManager.shared.context, sectionNameKeyPath: "transactionDay.day", cacheName: nil)
        return fetchResultController
    }()
    
    func getDataFromDB() {
        do {
            try fetchResultController.performFetch()
            
        } catch {
            print(error)
        }
    }
    
}



