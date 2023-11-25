//
//  PaymentRouter.swift
//  MIIBNI1QRIS
//
//  Created by Vincentius Ian Widi Nugroho on 23/11/23.
//

import Foundation
import UIKit

protocol PaymentRouterProtocol: AnyRouter{
    func backToHome()
}

class PaymentRouter: PaymentRouterProtocol {
    
    var entry: UIViewController?
    
    static func start(id: String, sumber: String, merchant: String, nominal: Int64, saldo: Int64) -> AnyRouter {
        let router = PaymentRouter()
        
        let view = PaymentView(id: id, sumber: sumber, merchant: merchant, nominal: nominal, saldo: saldo)
        let presenter = PaymentPresenter()
        let interactor = PaymentInteractor()
        
        view.presenter = presenter
        interactor.presenter = presenter
        
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        
        // set entry point
        router.entry = view
        
        return router
    }
        
    func backToHome() {
        if let view = self.entry{
            let viewControllers: [UIViewController] = view.navigationController!.viewControllers as [UIViewController]
            view.navigationController!.popToViewController(viewControllers[viewControllers.count - 3], animated: true)
        }
    }

}
