//
//  PortfolioRouter.swift
//  MIIBNI3Portfolio
//
//  Created by Vincentius Ian Widi Nugroho on 23/11/23.
//

import Foundation
import UIKit

protocol AnyRouter{
    var entry: UIViewController? {get}
    
    func moveToDetail(datas: [[String: Any]])
}

class PortfolioRouter: AnyRouter {
    
    var entry: UIViewController?
    
    static func start() -> AnyRouter {
        let router = PortfolioRouter()
        
        let view = PortfolioView()
        let presenter = PortfolioPresenter()
        let interactor = PortfolioInteractor()
        
        view.presenter = presenter
        interactor.presenter = presenter
        
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        
        // set entry point
        router.entry = view
        
        return router
    }
    
    func moveToDetail(datas: [[String: Any]]) {
        let view = DetailView(datas: datas)
        entry?.navigationController?.pushViewController(view, animated: true)
    }
}
