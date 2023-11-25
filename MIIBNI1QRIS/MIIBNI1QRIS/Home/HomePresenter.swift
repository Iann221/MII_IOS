//
//  HomePresenter.swift
//  MIIBNI1QRIS
//
//  Created by Vincentius Ian Widi Nugroho on 22/11/23.
//

import Foundation

protocol AnyPresenter {
    var router: AnyRouter? {get set}
    var interactor: AnyInteractor? {get set}
    var view: AnyView? {get set}
}

protocol HomePresenterProtocol: AnyPresenter {
    func interactorDidFetchSaldo(saldo: Int64)
    
    func viewDidTapQris()
    func viewDidTapHistory()
    func viewUpdateSaldo()
}

class HomePresenter: HomePresenterProtocol {
    var view: AnyView?
    var router: AnyRouter?{
        didSet {
            if let homeRouter = router as? HomeRouterProtocol {
                self.homeRouter = homeRouter
            }
        }
    }
    var interactor: AnyInteractor?
    var homeRouter: HomeRouterProtocol?
        
    func interactorDidFetchSaldo(saldo: Int64) {
        if let homeView = view as? HomeViewProtocol {
            homeView.updateSaldo(saldo: saldo)
        }
    }
    
    func viewDidTapQris() {
        homeRouter?.moveToQris()
    }
    
    func viewDidTapHistory() {
        homeRouter?.moveToHistory()
    }
    
    func viewUpdateSaldo() {
        if let homeInteractor = interactor as? HomeInteractorProtocol {
            homeInteractor.getCurrentSaldo()
        }
    }
    
}
