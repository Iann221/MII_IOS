//
//  HistoryRouter.swift
//  MIIBNI1QRIS
//
//  Created by Vincentius Ian Widi Nugroho on 23/11/23.
//

import Foundation
import UIKit

class HistoryRouter: AnyRouter {
    
    var entry: UIViewController?
    
    static func start() -> AnyRouter {
        let router = HistoryRouter()
        
        let view = HistoryView()
        let presenter = HistoryPresenter()
        let interactor = HistoryInteractor()
        
        view.presenter = presenter
        interactor.presenter = presenter
        
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        
        // set entry point
        router.entry = view
        
        return router
    }

}
