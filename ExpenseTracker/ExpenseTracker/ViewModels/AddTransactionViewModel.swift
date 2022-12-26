//
//  AddTransactionViewModel.swift
//  ExpenseTracker
//
//  Created by Kyzu on 25.12.22.
//

import Foundation

class AddTransactionViewModel {
    var managedWallet = CoreDataManager.shared.fetchCashInWallet()
    var transactions = CoreDataManager.shared.fetchTransactions()
    var currentCategory = Dynamic("Groceries")
    var isEnoughMoney = Dynamic(true)
    
    func processingTransaction(sum: Int) {
        print(managedWallet[0].cash)
        if managedWallet[0].cash < sum {
            isEnoughMoney.value = false
            
        } else {
            minusWallet(sum: sum)
            let trans = Transaction()
            trans.amount = Int64(sum)
            trans.category = self.currentCategory.value
            trans.date = Date.localDate()
            addTransaction(transaction: trans)
            isEnoughMoney.value = true
        }
    }
    
    func minusWallet(sum: Int) {
        managedWallet[0].cash -= Int64(sum)
        //CoreDataManager.shared.saveContext()
    }
    
    func addTransaction(transaction: Transaction) {
        transactions.append(transaction)
        print(transactions.count)
        CoreDataManager.shared.saveContext()
    }
}
