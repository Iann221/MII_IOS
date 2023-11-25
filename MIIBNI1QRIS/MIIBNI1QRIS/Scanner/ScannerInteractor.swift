//
//  ScannerInteractor.swift
//  MIIBNI1QRIS
//
//  Created by Vincentius Ian Widi Nugroho on 22/11/23.
//

import Foundation
import UIKit
import CoreData

protocol ScannerInteractorProtocol: AnyInteractor {
    func createTransaction(id: String, sumber: String, merchant: String, nominal: Int64)
}

class ScannerInteractor: ScannerInteractorProtocol {
    var presenter: AnyPresenter?
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func updateSaldo(nominal: Int64) {
        var user: User
        do{
            let users = (try context.fetch(User.fetchRequest()))
            user = users[users.count-1]
            user.saldo = user.saldo - nominal
            try context.save()
            
            if let scannerPresenter = presenter as? ScannerPresenterProtocol {
                scannerPresenter.interactorDidUpdateSaldo(saldo: user.saldo)
            }
        } catch{
            print("error")
        }
    }
    
    func createTransaction(id: String, sumber: String, merchant: String, nominal: Int64) {
        let transaction = Transaction(context: context)
        transaction.id = id
        transaction.sumber = sumber
        transaction.merchant = merchant
        transaction.nominal = nominal
        transaction.date = Date()
        do{
            try context.save()
        } catch{
            print("error saving data")
        }
        updateSaldo(nominal: nominal)
    }
}
