//
//  PromoRouter.swift
//  MIIBNI2Promo
//
//  Created by Vincentius Ian Widi Nugroho on 23/11/23.
//

import Foundation
import UIKit

protocol AnyRouter{
    var entry: UIViewController? {get}
    
    func moveToDetail(data: PromoEntity)
}

class PromoRouter: AnyRouter {
    
    var entry: UIViewController?
    
    static func start() -> AnyRouter {
        let router = PromoRouter()
        
        let view = PromoView()
        let presenter = PromoPresenter()
        let interactor = PromoInteractor()
        
        view.presenter = presenter
        interactor.presenter = presenter
        
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        
        // set entry point
        router.entry = view
        
        return router
    }
    
    func moveToDetail(data: PromoEntity) {
        let view = DetailView(data: data)
        entry?.navigationController?.pushViewController(view, animated: true)
    }
}
