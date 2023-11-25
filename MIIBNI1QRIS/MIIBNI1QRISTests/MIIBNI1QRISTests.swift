//
//  MIIBNI1QRISTests.swift
//  MIIBNI1QRISTests
//
//  Created by Vincentius Ian Widi Nugroho on 23/11/23.
//

import XCTest
@testable import MIIBNI1QRIS

final class MIIBNI1QRISTests: XCTestCase {
    var homeInteractor: HomeInteractor!
    var historyInteractor: HistoryInteractor!
    var scannerInteractor: ScannerInteractor!
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var users: [User] = []
    var transactions: [Transaction] = []

    override func setUpWithError() throws {
        homeInteractor = HomeInteractor()
        historyInteractor = HistoryInteractor()
        scannerInteractor = ScannerInteractor()
        
        users = homeInteractor.getAllUsers()
        transactions = historyInteractor.getAllTransactions()
        let user = User(context: context)
        homeInteractor.saveUser(user: user, saldo: 150000)
        scannerInteractor.createTransaction(id: "", sumber: "", merchant: "", nominal: 100)
    }

    override func tearDownWithError() throws {
        homeInteractor.deleteLastUser()
        historyInteractor.deleteLastTransaction()
        
        homeInteractor = nil
        historyInteractor = nil
    }

    func testCreateUser() throws {
        let users2 = homeInteractor.getAllUsers()
        XCTAssertEqual(users2.count, users.count+1, "error creating user data")
    }
    
    func testUpdateSaldo() throws {
        let users = homeInteractor.getAllUsers()
        let saldo: Int64 = users[users.count-1].saldo
        let nominal: Int64 = 10000
        scannerInteractor.updateSaldo(nominal: nominal)
        let updatedSaldo: Int64 = users[users.count-1].saldo
        XCTAssertEqual(saldo, updatedSaldo+nominal, "nominal salah")
    }
    
    func testCreateTransaction() throws {
        let trans2 = historyInteractor.getAllTransactions()
        XCTAssertEqual(trans2.count, transactions.count+1, "error creating user data")
    }

}
