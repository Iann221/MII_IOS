//
//  HistoryInteractor.swift
//  MIIBNI1QRIS
//
//  Created by Vincentius Ian Widi Nugroho on 23/11/23.
//

import Foundation
import UIKit
import CoreData

protocol HistoryInteractorProtocol: AnyInteractor {
    func fetchTransactions()
}

class HistoryInteractor: HistoryInteractorProtocol {
    var presenter: AnyPresenter?
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func fetchTransactions(){
        var transactions: [Transaction] = getAllTransactions()
        
        if let historyPresenter = presenter as? HistoryPresenterProtocol {
            historyPresenter.interactorDidFetchTransactions(transactions: transactions)
        }
    }
    
    func getAllTransactions() -> [Transaction]{
        var transactions: [Transaction] = []
        do{
            transactions = try context.fetch(Transaction.fetchRequest())
            return transactions
        } catch{
            print("error fetching data")
        }
        return transactions
    }
    
    func deleteLastTransaction(){
        do{
            let trans = try context.fetch(Transaction.fetchRequest())
            context.delete(trans[trans.count-1])
            try context.save()
        } catch{
            print("error saving data")
        }
    }
}
