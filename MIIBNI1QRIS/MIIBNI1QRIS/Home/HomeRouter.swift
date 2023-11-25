//
//  HomeRouter.swift
//  MIIBNI1QRIS
//
//  Created by Vincentius Ian Widi Nugroho on 22/11/23.
//

import Foundation
import UIKit

protocol AnyRouter{
    var entry: UIViewController? {get}
}

protocol HomeRouterProtocol: AnyRouter{
    func moveToQris()
    func moveToHistory()
}

class HomeRouter: HomeRouterProtocol {
    
    var entry: UIViewController?
    
    static func start() -> AnyRouter {
        let router = HomeRouter()
        
        let view = HomeView()
        let presenter = HomePresenter()
        let interactor = HomeInteractor()
        
        view.presenter = presenter
        interactor.presenter = presenter
        
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        
        // set entry point
        router.entry = view
        
        return router
    }
    
    func moveToQris() {
        if let view = ScannerRouter.start().entry {
            entry?.navigationController?.pushViewController(view, animated: true)
        }
    }
    
    func moveToHistory() {
        if let view = HistoryRouter.start().entry {
            entry?.navigationController?.pushViewController(view, animated: true)
        }
    }
}
