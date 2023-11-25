//
//  HistoryPresenter.swift
//  MIIBNI1QRIS
//
//  Created by Vincentius Ian Widi Nugroho on 23/11/23.
//

import Foundation

protocol HistoryPresenterProtocol: AnyPresenter {
    func interactorDidFetchTransactions(transactions: [Transaction])
}

class HistoryPresenter: HistoryPresenterProtocol {
    var view: AnyView?
    var router: AnyRouter?
    var interactor: AnyInteractor?{
        didSet {
            if let historyInteractor = interactor as? HistoryInteractorProtocol {
                historyInteractor.fetchTransactions()
            }
        }
    }
    
    func interactorDidFetchTransactions(transactions: [Transaction]) {
        if let historyView = view as? HistoryViewProtocol {
            historyView.updateTransactions(transactions: transactions)
        }
    }
    
}
